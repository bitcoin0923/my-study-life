import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import 'package:group_list_view/group_list_view.dart';
import "package:collection/collection.dart";

import '../../app.dart';
import './custom_segmentedcontrol.dart';
import '../Models/holidays_datasource.dart';
import '../Widgets/HolidayWidgets/holiday_widget.dart';
import '../Models/Services/storage_service.dart';
import 'dart:convert';

import './holiday_xtra_detail_screen.dart';
import '../Models/API/holiday.dart';

class ActivitiesHolidaysScreen extends StatefulWidget {
  const ActivitiesHolidaysScreen({super.key});

  @override
  State<ActivitiesHolidaysScreen> createState() =>
      _ActivitiesHolidaysScreenState();
}

class _ActivitiesHolidaysScreenState extends State<ActivitiesHolidaysScreen> {
  int selectedTabIndex = 1;
  final todaysDate = DateTime.now();
  List<Holiday> _allHolidaysPast = [];
  List<Holiday> _allHolidaysUpcoming = [];

  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  void getData() async {
    var upcomingHolidaysData =
        await _storageService.readSecureData("user_holidays_upcoming");

    List<dynamic> decodedDataUpcomingClasses =
        jsonDecode(upcomingHolidaysData ?? "");

    var pastHolidaysData =
        await _storageService.readSecureData("user_holidays_past");

    List<dynamic> decodedDataPastClasses = jsonDecode(pastHolidaysData ?? "");

    if (!context.mounted) return;

    setState(() {
      _allHolidaysUpcoming = List<Holiday>.from(
        decodedDataUpcomingClasses
            .map((x) => Holiday.fromJson(x as Map<String, dynamic>)),
      );

      _allHolidaysPast = List<Holiday>.from(
        decodedDataPastClasses
            .map((x) => Holiday.fromJson(x as Map<String, dynamic>)),
      );
    });
  }

  void _selectedCard(IndexPath index, Holiday item) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => HolidayXtraDetailScreen(
                  item: item,
                  xtraItem: null,
                ),
            fullscreenDialog: true));
  }

  void _selectedTabWithIndex(int index) {
    setState(() {
      selectedTabIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      final startOfWeek = todaysDate.findFirstDateOfTheWeek(todaysDate);
      final endOfWeek = todaysDate.findLastDateOfTheWeek(todaysDate);

      var groupByDateUpcoming = groupBy(_allHolidaysUpcoming,
          (obj) => obj.getStartDate().isBetween(startOfWeek, endOfWeek));

      var groupByDatePast = groupBy(_allHolidaysPast,
          (obj) => obj.getStartDate().isBetween(startOfWeek, endOfWeek));

      return Stack(
        children: [
          Container(
            height: 45,
            //width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
            child: CustomSegmentedControl(
              _selectedTabWithIndex,
              tabs: {
                1: Text(
                  'Upcoming',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
                2: Text(
                  'Past',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 80),
            child: GroupListView(
              sectionsCount: selectedTabIndex == 1
                  ? groupByDateUpcoming.keys.toList().length
                  : groupByDatePast.keys.toList().length,
              countOfItemInSection: (int section) {
                return selectedTabIndex == 1
                    ? groupByDateUpcoming.values.toList()[section].length
                    : groupByDatePast.values.toList()[section].length;
              },
              itemBuilder: (BuildContext context, IndexPath index) {
                return HolidayWidget(
                    holidayItem: selectedTabIndex == 1
                        ? groupByDateUpcoming.values.toList()[index.section]
                            [index.index]
                        : groupByDatePast.values.toList()[index.section]
                            [index.index],
                    cardIndex: index,
                    upNext: true,
                    cardselected: _selectedCard);
              },
              groupHeaderBuilder: (BuildContext context, int section) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: section == 0
                      ? Text(
                          selectedTabIndex == 1
                              ? 'This week (${groupByDateUpcoming.values.toList()[section].length})'
                              : 'Past (${groupByDatePast.values.toList()[section].length})',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Colors.black.withOpacity(0.6)
                                : Colors.white.withOpacity(0.6),
                          ),
                        )
                      : Text(
                          selectedTabIndex == 1
                              ? 'This month (${groupByDateUpcoming.values.toList()[section].length})'
                              : 'This month (${groupByDatePast.values.toList()[section].length})',
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Colors.black.withOpacity(0.6)
                                : Colors.white.withOpacity(0.6),
                          ),
                        ),
                );
              },
              separatorBuilder: (context, index) => SizedBox(height: 10),
              sectionSeparatorBuilder: (context, section) =>
                  SizedBox(height: 10),
            ),
          )
        ],
      );
    });
  }
}
