import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';
import '../datetime_selection_textfield.dart';

class SelectTaskRepeatOptions extends StatefulWidget {
  final Function repeatOptionSelected;
  final Function dateSelected;
  const SelectTaskRepeatOptions(
      {super.key,
      required this.repeatOptionSelected,
      required this.dateSelected});

  @override
  State<SelectTaskRepeatOptions> createState() =>
      _SelectTaskRepeatOptionsState();
}

class _SelectTaskRepeatOptionsState extends State<SelectTaskRepeatOptions> {
  final List<ClassTagItem> _repeatOptions = ClassTagItem.taskRepeatOptions;
  final dateController = TextEditingController();

  int selectedTabIndex = 0;
  late DateTime date = DateTime.now();

  @override
  void initState() {
    dateController.text = "Fri, 4 Mar 2023";
    super.initState();
  }

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _repeatOptions) {
        item.selected = false;
      }

      _repeatOptions[index].selected = true;
      widget.repeatOptionSelected(_repeatOptions[index]);
    });
  }

  void _showiOSDateSelectionDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }

  // Date pickers

  void _showAndroidDateSelectionDialog(ThemeMode theme, bool isDateFrom) {
    _showAndroidDatePicker(context, theme == ThemeMode.light, isDateFrom);
  }

  Future<void> _showAndroidDatePicker(
      BuildContext context, bool isLightTheme, bool isDateFrom) async {
    final DateTime? picked = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: ColorScheme.light(
                primary: isLightTheme
                    ? Constants.lightThemePrimaryColor
                    : Constants
                        .darkThemeBackgroundColor, // header background color
                onPrimary: isLightTheme
                    ? Colors.black
                    : Constants.darkThemePrimaryColor, // header text color
                onSurface: isLightTheme
                    ? Colors.grey
                    : Constants.darkThemeSecondaryColor, // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: isLightTheme
                      ? Colors.black
                      : Constants.darkThemePrimaryColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDatePickerMode: DatePickerMode.year,
        initialDate: date,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2025, 12));
    if (picked != null && picked != date) {
      setState(() {
        date = picked;
        dateController.text = DateFormat('EEE, d MMM, yyyy').format(picked);
        widget.dateSelected(picked);
      });
    }
  }

  void _showDatePicker(ThemeMode theme, bool isDateFrom) {
    Platform.isAndroid
        ? _showAndroidDateSelectionDialog
        : _showiOSDateSelectionDialog(CupertinoDatePicker(
            initialDateTime: DateTime.now(),
            mode: CupertinoDatePickerMode.date,
            use24hFormat: true,
            onDateTimeChanged: (DateTime newDate) {
              setState(() {
                date = newDate;
                dateController.text =
                    DateFormat('EEE, d MMM, yyyy').format(newDate);
                widget.dateSelected(newDate);
              });
            },
          ));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        // Tag items
        // height: 34,
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Repeat Options',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: _repeatOptions
                  .mapIndexed((e, i) => TagCard(
                        title: e.title,
                        selected: e.selected,
                        cardIndex: e.cardIndex,
                        cardselected: _selectTab,
                        isAddNewCard: e.isAddNewCard,
                      ))
                  .toList(),
            ),
            Container(
              height: 14,
            ),
            if (selectedTabIndex == 0) ...[
              Container(
                width: 140,
                child: DateTimeSelectionTextField(
                  dateController.text,
                  Platform.isAndroid
                      ? _showAndroidDateSelectionDialog
                      : _showDatePicker,
                  textController: dateController,
                  isDateFrom: false,
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
