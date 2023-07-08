import 'package:flutter/material.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Calendar_Screens/calendar_screen.dart';
import '../../Utilities/constants.dart';

class CustomTimelineDatePicker extends StatefulWidget {
  final Function daySelected;
  final Function pageChanged;
  final DateTime selectedDay;

 const CustomTimelineDatePicker(
      {super.key, required this.daySelected, required this.pageChanged, required this.selectedDay});

  @override
  State<CustomTimelineDatePicker> createState() =>
      _CustomTimelineDatePickerState();
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 24, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 24, kToday.day);

class _CustomTimelineDatePickerState extends State<CustomTimelineDatePicker> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime? _focusedDay;
  DateTime? _selectedDay;

  // @override
  // void initState() {
  //   super.initState();
  //   _focusedDay = widget.selectedDay;
  // }

  SizedBox _createDayView(
      String day, String weekDay, ThemeMode theme, bool isSelected) {
    return SizedBox(
      width: 64,
      height: 90,
      child: Container(
        width: 54,
        height: 80,
        margin: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color: isSelected
                ? Constants.lightThemePrimaryColor
                : theme == ThemeMode.light
                    ? Colors.white
                    : Constants.darkThemeSecondaryBackgroundColor,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.1),
                blurRadius: 2.0,
                spreadRadius: 1.0,
              ),
            ]),
        child: Container(
          margin: const EdgeInsets.only(left: 8, right: 8, top: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                day,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Constants.lightThemeCalendaryDayColor
                        : theme == ThemeMode.light
                            ? Constants.lightThemeCalendaryDayColor
                            : Colors.white),
              ),
              Text(
                weekDay,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: isSelected
                        ? Constants.lightThemeCalendaryDayColor
                        : theme == ThemeMode.light
                            ? Constants.lightThemeCalendaryDayColor
                            : Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        child: TableCalendar(
          rowHeight: 90,
          firstDay: kFirstDay,
          lastDay: kLastDay,
          focusedDay: widget.selectedDay,
          currentDay: widget.selectedDay,
          calendarFormat: _calendarFormat,
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              return Container();
            },
            todayBuilder: (context, day, focusedDay) {
              final String dayString = day.dateToStringWithFormat(format: "dd");
              final String dayOfWeekString =
                  day.dateToStringWithFormat(format: "EEE");
              return _createDayView(dayString, dayOfWeekString, theme, true);
            },
            defaultBuilder: (context, day, focusedDay) {
              final String dayString = day.dateToStringWithFormat(format: "dd");
              final String dayOfWeekString =
                  day.dateToStringWithFormat(format: "EEE");
              return _createDayView(dayString, dayOfWeekString, theme, false);
            },
            selectedBuilder: (context, day, focusedDay) {
              final String dayString = day.dateToStringWithFormat(format: "dd");
              final String dayOfWeekString =
                  day.dateToStringWithFormat(format: "EEE");
              return _createDayView(dayString, dayOfWeekString, theme, true);
            },
            outsideBuilder: (context, day, focusedDay) {
              final String dayString = day.dateToStringWithFormat(format: "dd");
              final String dayOfWeekString =
                  day.dateToStringWithFormat(format: "EEE");
              return _createDayView(dayString, dayOfWeekString, theme, false);
            },
          ),
          headerVisible: false,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.

            // Using `isSameDay` is recommended to disregard
            // the time-part of compared DateTime objects.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              // Call `setState()` when updating the selected day
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                widget.daySelected(selectedDay);
              });
            }
          },
          onFormatChanged: (format) {
            if (_calendarFormat != format) {
              // Call `setState()` when updating calendar format
              setState(() {
                _calendarFormat = format;
              });
            }
          },
          onPageChanged: (focusedDay) {
            // No need to call `setState()` here
            _focusedDay = focusedDay;
            widget.pageChanged(focusedDay);
          },
        ),
      );
    });
  }
}
