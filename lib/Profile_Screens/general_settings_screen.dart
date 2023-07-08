import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Models/exam_datasource.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../../Models/subjects_datasource.dart';
import '../Widgets/ProfileWidgets/select_first_day.dart';
import '../Widgets/ProfileWidgets/start_time_and_duration.dart';
import '../Widgets/ProfileWidgets/rotation_schedule.dart';
import '../Models/class_datasource.dart';
import '../Widgets/ProfileWidgets/days_to_display.dart';
import '../Widgets/ProfileWidgets/dark_mode_setting.dart';
import '../Widgets/ProfileWidgets/number_of_weeks.dart';
import '../Widgets/ProfileWidgets/start_week.dart';
import '../Widgets/ProfileWidgets/start_day.dart';
import '../Widgets/ProfileWidgets/number_of_days.dart';
import '../Widgets/ClassWidgets/class_days.dart';

enum RotationSchedule { fixed, weekly, lettered }

class GeneralSettingsScreen extends StatefulWidget {
  const GeneralSettingsScreen({super.key});

  @override
  State<GeneralSettingsScreen> createState() => _GeneralSettingsScreenState();
}

class _GeneralSettingsScreenState extends State<GeneralSettingsScreen> {
  final ScrollController scrollcontroller = ScrollController();

  RotationSchedule rotation = RotationSchedule.fixed;
  bool addStartEndDates = false;

  // void _rotationSelected(RotationSchedule rotationItem) {
  //   print("Selected subject: ${rotationItem}");
  // }

  void _firstDaySelected(ClassTagItem day) {
    print("Selected mode: ${day.title}");

    // setState(() {

    // });
  }

  void _dayToDisplaySelected(ClassTagItem day) {
    print("Selected day: ${day.title}");

    // setState(() {

    // });
  }

  void _numberOfWeeksSelected(ClassTagItem day) {
    print("Selected week: ${day.title}");

    // setState(() {

    // });
  }

  void _startWeekSelected(ClassTagItem day) {
    print("Selected start week: ${day.title}");

    // setState(() {

    // });
  }

  void _numberOfDaysSelected(ClassTagItem day) {
    print("Selected week: ${day.title}");

    // setState(() {

    // });
  }

  void _startDaySelected(ClassTagItem day) {
    print("Selected start day: ${day.title}");

    // setState(() {

    // });
  }

  void _switchedDarkMode(ClassTagItem day, WidgetRef ref) {
    print("Selected mode: ${day.title}");

    // setState(() {

    // });
    ref.read(themeModeProvider.notifier).state = ThemeMode.light;
  }

  void _classDaysSelected(List<ClassTagItem> days) {
    print("Selected repetitionMode: ${days}");
  }

  void _classRepetitionSelected(RotationScheduleItem repetition) {
    setState(() {
      rotation = repetition.rotation;
    });
    print("Selected repetitionMode: ${repetition.rotation.name}");
  }

  void _selectedTime(DateTime time) {
    //print("Selected repetitionMode: ${repetition.title}");
  }

  void _selectedDuration(ExamDuration duration) {
    //print("Selected repetitionMode: ${repetition.title}");
  }

  // void _aysSelected(List<ClassTagItem> days) {
  //   print("Selected repetitionMode: ${days}");
  // }

  void _saveClass() {}

  void _cancel() {
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            "General",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
        ),
        body: Container(
          color: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          child: ListView.builder(
              controller: scrollcontroller,
              padding: const EdgeInsets.only(top: 8),
              itemCount: rotation == RotationSchedule.weekly
                  ? 7
                  : rotation == RotationSchedule.lettered
                      ? 8
                      : 6,
              itemBuilder: (context, index) {
                // Add Questions
                return Column(
                  children: [
                    if (index == 0) ...[
                      // Select First day
                      SelectFirstDay(
                        subjectSelected: _firstDaySelected,
                      )
                    ],
                    Container(
                      height: 14,
                    ),
                    if (index == 1) ...[
                      // Select time and Duration
                      StartTimeAndDuration(
                        timeSelected: _selectedTime,
                        durationSelected: _selectedDuration,
                      )
                    ],
                    if (index == 2) ...[
                      // Add Rotation
                      RotationScheduleSelector(
                          rotationSelected: _classRepetitionSelected),
                      if (rotation == RotationSchedule.fixed) ...[
                        Container(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            "Clases occur on the same day every week",
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeRegular14TextStyle
                                : Constants.darkThemeRegular14TextStyle,
                            textAlign: TextAlign.left,
                          ),
                        )
                      ],
                      if (rotation == RotationSchedule.weekly) ...[
                        Container(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            "Clases occur on the same day every x weeks",
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeRegular14TextStyle
                                : Constants.darkThemeRegular14TextStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 16,
                        ),
                        NumberOfWeeks(daySelected: _numberOfWeeksSelected),
                        Container(
                          height: 16,
                        ),
                        StartWeek(startWeekSelected: _startWeekSelected),
                      ],
                      if (rotation == RotationSchedule.lettered) ...[
                        Container(
                          height: 8,
                        ),
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.only(left: 40),
                          child: Text(
                            "Clases rotate according to the schedule day",
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeRegular14TextStyle
                                : Constants.darkThemeRegular14TextStyle,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Container(
                          height: 16,
                        ),
                        NumberOfDays(daySelected: _numberOfDaysSelected),
                        Container(
                          height: 16,
                        ),
                        StartDay(startDaySelected: _startDaySelected),
                        Container(
                          height: 16,
                        ),
                        ClassWeekDays(
                          subjectSelected: _classDaysSelected,
                        )
                      ],
                    ],
                    if (index == 3) ...[
                      // if (rotation == RotationSchedule.fixed) ...[
                      DaysToDisplay(daySelected: _dayToDisplaySelected)
                      // ],
                    ],
                    if (index == 4) ...[
                      // Select Week days
                      DarkModeSettingh(daySelected: (value) {
                        var mode = value.cardIndex;
                        switch (mode) {
                          case 0:
                            var brightness = WidgetsBinding
                                .instance.window.platformBrightness;

                            if (brightness == Brightness.dark) {
                              ref.read(themeModeProvider.notifier).state =
                                  ThemeMode.dark;
                            } else {
                              ref.read(themeModeProvider.notifier).state =
                                  ThemeMode.light;
                            }
                            break;
                          case 1:
                            ref.read(themeModeProvider.notifier).state =
                                ThemeMode.dark;
                            break;
                          case 2:
                            ref.read(themeModeProvider.notifier).state =
                                ThemeMode.light;
                        }
                      })
                    ],
                  ],
                );
                // );
              }),
        ),
      );
    });
  }
}
