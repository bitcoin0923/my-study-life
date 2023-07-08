import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import 'package:group_list_view/group_list_view.dart';
import "package:collection/collection.dart";
import 'dart:convert';

import '../../app.dart';
import './custom_segmentedcontrol.dart';
import '../Models/holidays_datasource.dart';
import '../Widgets/ExtrasWidgets/extras_widget.dart';

import './holiday_xtra_detail_screen.dart';
import '../Models/API/xtra.dart';
import '../Models/Services/storage_service.dart';

class ActivitiesExtrasScreen extends StatefulWidget {
  const ActivitiesExtrasScreen({super.key});

  @override
  State<ActivitiesExtrasScreen> createState() => _ActivitiesExtrasScreenState();
}

class _ActivitiesExtrasScreenState extends State<ActivitiesExtrasScreen> {
  final List<HolidayItem> _holidays = HolidayItem.extras;
  int selectedTabIndex = 1;
  final todaysDate = DateTime.now();

  List<Xtra> _allXtrasAcademic = [];
  List<Xtra> _allXtrasNonAcademic = [];

  final StorageService _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  void getData() async {
    var academicXtrasData =
        await _storageService.readSecureData("user_xtras_academic");

    List<dynamic> decodedDataAcademic = jsonDecode(academicXtrasData ?? "");

    var nonAcademicXtrasData =
        await _storageService.readSecureData("user_xtras_nonacademic");

    List<dynamic> decodedDataNonAcademic =
        jsonDecode(nonAcademicXtrasData ?? "");

    if (!context.mounted) return;

    setState(() {
      _allXtrasAcademic = List<Xtra>.from(
        decodedDataAcademic
            .map((x) => Xtra.fromJson(x as Map<String, dynamic>)),
      );

      _allXtrasNonAcademic = List<Xtra>.from(
        decodedDataNonAcademic
            .map((x) => Xtra.fromJson(x as Map<String, dynamic>)),
      );
    });
  }

  void _selectedCard(IndexPath index, Xtra xtraItem) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                HolidayXtraDetailScreen(item: null, xtraItem: xtraItem),
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

      // var groupByDate = groupBy(
      //     _holidays, (obj) => obj.dateFrom.isBetween(startOfWeek, endOfWeek));

      var groupByDateAcademic = groupBy(_allXtrasAcademic,
          (obj) => obj.getStartDate().isBetween(startOfWeek, endOfWeek));

      var groupByDateNonAcademic = groupBy(_allXtrasNonAcademic,
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
                  'Academic',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
                2: Text(
                  'Non-Academic',
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
                  ? groupByDateAcademic.keys.toList().length
                  : groupByDateNonAcademic.keys.toList().length,
              countOfItemInSection: (int section) {
                return selectedTabIndex == 1
                    ? groupByDateAcademic.values.toList()[section].length
                    : groupByDateNonAcademic.values.toList()[section].length;
              },
              itemBuilder: (BuildContext context, IndexPath index) {
                return ExtrasWidget(
                    xtraItem: selectedTabIndex == 1
                        ? groupByDateAcademic.values.toList()[index.section]
                            [index.index]
                        : groupByDateNonAcademic.values.toList()[index.section]
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
                              ? 'This week (${groupByDateAcademic.values.toList()[section].length})'
                              : 'Past (${groupByDateNonAcademic.values.toList()[section].length})',
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
                              ? 'This month (${groupByDateAcademic.values.toList()[section].length})'
                              : 'This month (${groupByDateNonAcademic.values.toList()[section].length})',
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
