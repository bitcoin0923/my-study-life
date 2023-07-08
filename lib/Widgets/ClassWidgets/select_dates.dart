import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';
import '../regular_teztField.dart';
import '../../app.dart';
import '../../Models/subjects_datasource.dart';
import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../datetime_selection_textfield.dart';
import '../../Models/API/classmodel.dart';
import '../../Models/API/holiday.dart';
import '../../Models/API/xtra.dart';

class SelectDates extends StatefulWidget {
  final Function dateSelected;
  final bool shouldDisableEndDate;
  final ClassModel? classItem;
  final Holiday? holidayItem;
  final Xtra? xtraItem;

  const SelectDates(
      {super.key,
      required this.dateSelected,
      required this.shouldDisableEndDate,
      this.classItem,
      this.holidayItem,
      this.xtraItem});

  @override
  State<SelectDates> createState() => _SelectDatesState();
}

class _SelectDatesState extends State<SelectDates> {
  final dateFromController = TextEditingController();
  final dateToController = TextEditingController();

  final List<ClassTagItem> _subjects = ClassTagItem.subjectModes;

  int selectedTabIndex = 0;
  late DateTime dateFrom = DateTime.now();
  late DateTime dateTo = DateTime.now();

  @override
  void initState() {
    if (widget.classItem != null) {
      dateFromController.text =
          widget.classItem?.getFormattedStartDate() ?? "Fri, 4 Mar 2023";
      dateToController.text =
          widget.classItem?.getFormattedEndDate() ?? "Fri, 4 Mar 2023";
    } else if (widget.holidayItem != null) {
      dateFromController.text =
          widget.holidayItem?.getFormattedStartDate() ?? "Fri, 4 Mar 2023";
      dateToController.text =
          widget.holidayItem?.getFormattedEndDate() ?? "Fri, 4 Mar 2023";
    } 
    else if (widget.xtraItem != null) {
      dateFromController.text =
          widget.xtraItem?.getFormattedStartDate() ?? "Fri, 4 Mar 2023";
      dateToController.text =
          widget.xtraItem?.getFormattedEndDate() ?? "Fri, 4 Mar 2023";
    }else {
      dateFromController.text = "Fri, 4 Mar 2023";
      dateToController.text = "Fri, 4 Mar 2023";
    }

    super.initState();
  }

  String _getFormattedTime(DateTime time) {
    var localDate = time.toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat('HH:mm');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  void _tappedOnDateFrom(ThemeMode theme, bool isDateFrom) {
    _showDatePicker(theme, isDateFrom);
  }

  void _tappedOnDateTo(ThemeMode theme, bool isDateFrom) {
    // if (!widget.shouldDisableEndDate) {
    //   print("ADSDASADSA ${widget.shouldDisableEndDate}");
    //   _showDatePicker(theme, isDateFrom);
    // }
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

  void _showAndroidDateSelectionDialog(ThemeMode theme, bool isDateFrom) {
    if (!widget.shouldDisableEndDate && isDateFrom) {
      _showAndroidDatePicker(context, theme == ThemeMode.light, isDateFrom);
    }
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
        initialDate: dateFrom,
        firstDate: DateTime(1950, 1),
        lastDate: DateTime(2025, 12));
    if (picked != null && picked != (isDateFrom ? dateFrom : dateTo)) {
      setState(() {
        isDateFrom ? dateFrom = picked : dateTo = picked;
        isDateFrom
            ? dateFromController.text =
                DateFormat('EEE, d MMM, yyyy').format(picked)
            : dateToController.text =
                DateFormat('EEE, d MMM, yyyy').format(picked);
        widget.dateSelected(picked, isDateFrom);
      });
    }
  }

  void _showDatePicker(ThemeMode theme, bool isDateFrom) {
    if (!widget.shouldDisableEndDate ||
        widget.shouldDisableEndDate && isDateFrom) {
      Platform.isAndroid
          ? _showAndroidDateSelectionDialog
          : _showiOSDateSelectionDialog(CupertinoDatePicker(
              initialDateTime: DateTime.now(),
              mode: CupertinoDatePickerMode.date,
              use24hFormat: true,
              onDateTimeChanged: (DateTime newDate) {
                setState(() {
                  if (isDateFrom) {
                    widget.dateSelected(newDate, true);
                    dateFromController.text =
                        DateFormat('EEE, d MMM, yyyy').format(newDate);
                  } else {
                    widget.dateSelected(newDate, false);
                    dateToController.text =
                        DateFormat('EEE, d MMM, yyyy').format(newDate);
                  }
                });
              },
            ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        // Tag items
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 90,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start Date*',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      DateTimeSelectionTextField(
                        dateFromController.text,
                        Platform.isAndroid
                            ? _showAndroidDateSelectionDialog
                            : _showDatePicker,
                        // Platform.isAndroid
                        //     ? _showAndroidDateSelectionDialog
                        //     : () => _showiOSDateSelectionDialog(
                        //             CupertinoTimerPicker(
                        //           mode: CupertinoTimerPickerMode.hm,
                        //           minuteInterval: 1,
                        //           initialTimerDuration: Duration.zero,
                        //           onTimerDurationChanged:
                        //               (Duration changeTimer) {
                        //             setState(() {
                        //               pickedTimeFrom =
                        //                   minutesToTimeOfDay(changeTimer);
                        //               print("ADASDADASDAD $pickedTimeFrom");
                        //             });
                        //           },
                        //         )),
                        textController: dateFromController, isDateFrom: true,
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 90,
                  width: 150,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'End Date*',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      DateTimeSelectionTextField(
                        dateToController.text,
                        Platform.isAndroid
                            ? _showAndroidDateSelectionDialog
                            : _showDatePicker,
                        textController: dateToController,
                        isDateFrom: false,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }
}
