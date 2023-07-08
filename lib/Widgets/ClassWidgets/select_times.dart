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
import '../../Models/API/xtra.dart';

class SelectTimes extends StatefulWidget {
  final Function timeSelected;
  final ClassModel? classItem;
  final Xtra? xtraItem;
  SelectTimes(
      {super.key, required this.timeSelected, this.classItem, this.xtraItem});

  @override
  State<SelectTimes> createState() => _SelectTimesState();
}

class _SelectTimesState extends State<SelectTimes> {
  final timeFromController = TextEditingController();
  final timeToController = TextEditingController();

  final List<ClassTagItem> _subjects = ClassTagItem.subjectModes;

  int selectedTabIndex = 0;
  late TimeOfDay pickedTimeFrom = const TimeOfDay(hour: 08, minute: 00);
  late TimeOfDay pickedTimeTo = const TimeOfDay(hour: 09, minute: 00);

  @override
  void initState() {
    if (widget.classItem != null) {
      TimeOfDay startTime = toTimeOfDay(widget.classItem?.startTime);
      TimeOfDay endTime = toTimeOfDay(widget.classItem?.endTime);

      var fullstartDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, startTime.hour, startTime.minute);
      var fullendDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, endTime.hour, endTime.minute);

      timeFromController.text = _getFormattedTime(fullstartDate);
      timeToController.text = _getFormattedTime(fullendDate);
    } 
    else if (widget.xtraItem != null) {
      TimeOfDay startTime = toTimeOfDay(widget.xtraItem?.startTime);
      TimeOfDay endTime = toTimeOfDay(widget.xtraItem?.endTime);

      var fullstartDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, startTime.hour, startTime.minute);
      var fullendDate = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, endTime.hour, endTime.minute);

      timeFromController.text = _getFormattedTime(fullstartDate);
      timeToController.text = _getFormattedTime(fullendDate);
    } 
    else {
      timeFromController.text = "9:00AM";
      timeToController.text = "10:30AM";
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

  TimeOfDay toTimeOfDay(String? time) {
    if (time != null && time.isNotEmpty) {
      List<String> timeSplit = time.split(":");
      int hour = int.parse(timeSplit.first);
      int minute = int.parse(timeSplit[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } else {
      return TimeOfDay.now();
    }
  }

  void _tappedOnTimeFrom(ThemeMode theme, bool isDateFrom) {
    _showDatePicker(theme, isDateFrom);
  }

  void _tappedOnTimeTo(ThemeMode theme, bool isDateFrom) {
    _showDatePicker(theme, isDateFrom);
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
    _showAndroidDatePicker(context, theme == ThemeMode.light, isDateFrom);
  }

  Future<void> _showAndroidDatePicker(
      BuildContext context, bool isLightTheme, bool isDateFrom) async {
    final TimeOfDay? picked = await showTimePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              timePickerTheme: TimePickerThemeData(
                backgroundColor: isLightTheme
                    ? Constants.lightThemeBackgroundColor
                    : Constants.darkThemeBackgroundColor,
                hourMinuteColor: isLightTheme
                    ? Colors.grey
                    : Constants.darkThemeSecondaryBackgroundColor,
                hourMinuteTextColor: isLightTheme
                    ? Constants.lightThemePrimaryColor
                    : Constants.darkThemePrimaryColor,
                dayPeriodColor: isLightTheme
                    ? Colors.grey
                    : Constants.darkThemeSecondaryBackgroundColor,
                dayPeriodTextColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.selected)
                        ? isLightTheme
                            ? Constants.lightThemePrimaryColor
                            : Constants.darkThemePrimaryColor
                        : isLightTheme
                            ? Colors.black
                            : Colors.grey),
                dialTextColor: MaterialStateColor.resolveWith(
                    (states) => states.contains(MaterialState.selected)
                        ? isLightTheme
                            ? Constants.lightThemePrimaryColor
                            : Constants.darkThemePrimaryColor
                        : Colors.grey),
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
        initialTime: TimeOfDay(hour: 08, minute: 00));
    if (picked != null) {
      setState(() {
        pickedTimeFrom = picked;
        // print(picked.format(context)); //output 10:51 PM
        widget.timeSelected(picked, isDateFrom);
      });
    }
  }

  void _showDatePicker(ThemeMode theme, bool isDateFrom) {
    Platform.isAndroid
        ? _showAndroidDateSelectionDialog
        : _showiOSDateSelectionDialog(CupertinoTimerPicker(
            mode: CupertinoTimerPickerMode.hm,
            minuteInterval: 1,
            initialTimerDuration: Duration.zero,
            onTimerDurationChanged: (Duration changeTimer) {
              setState(() {
                if (isDateFrom) {
                  pickedTimeFrom = minutesToTimeOfDay(changeTimer);
                  widget.timeSelected(pickedTimeFrom, isDateFrom);
                  timeFromController.text = pickedTimeFrom.format(context);
                } else {
                  pickedTimeTo = minutesToTimeOfDay(changeTimer);
                  timeToController.text = pickedTimeTo.format(context);
                  widget.timeSelected(pickedTimeTo, isDateFrom);
                }
              });
            },
          ));
  }

  TimeOfDay minutesToTimeOfDay(duration) {
    List<String> parts = duration.toString().split(':');
    return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
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
                        'Start Time*',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      DateTimeSelectionTextField(
                        timeFromController.text,
                        Platform.isAndroid
                            ? _showAndroidDateSelectionDialog
                            : _showDatePicker,
                        textController: timeFromController,
                        isDateFrom: true,
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
                        'End Time',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      DateTimeSelectionTextField(
                        timeToController.text,
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
                        textController: timeToController, isDateFrom: false,
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
