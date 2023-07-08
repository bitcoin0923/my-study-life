import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../ClassWidgets/select_subject.dart';
import '../../Models/subjects_datasource.dart';
import '../rounded_elevated_button.dart';
import '../TaskWidgets/task_text_imputs.dart';
import './select_eventType.dart';
import '../ClassWidgets/class_repetition.dart';
import '../ClassWidgets/class_days.dart';
import '../ClassWidgets/select_times.dart';
import '../HolidayWidgets/holiday_text_imputs.dart';
import '../add_photo_widget.dart';
import '../../Models/API/xtra.dart';
import '../switch_row_widget.dart';
import '../ClassWidgets/select_dates.dart';
import 'package:intl/intl.dart';

class CreateExtra extends StatefulWidget {
  final Function saveXtra;
  final Xtra? xtraItem;
  const CreateExtra({super.key, required this.saveXtra, this.xtraItem});

  @override
  State<CreateExtra> createState() => _CreateExtraState();
}

class _CreateExtraState extends State<CreateExtra> {
  final ScrollController scrollcontroller = ScrollController();

  late Xtra newXtra = Xtra(
    occurs: "once",
  );
  bool isEditing = false;
  bool isOccurringOnce = true;
  bool addStartEndDates = false;

  @override
  void initState() {
    checkForEditedXtra();
    super.initState();
  }

  @override
  void dispose() {
    newXtra = Xtra(
      occurs: "once",
    );
    newXtra.days = [];
    isEditing = false;
    isOccurringOnce = true;
    addStartEndDates = false;

    super.dispose();
  }

  void checkForEditedXtra() {
    if (widget.xtraItem != null) {
      isEditing = true;
      newXtra = widget.xtraItem!;

      if (newXtra.occurs != "once") {
        isOccurringOnce = false;
      }
    }
  }

  void _switchChangedState(bool isOn, int index) {
    setState(() {
      addStartEndDates = isOn;
    });
  }

  void _xtraOccuringSelected(ClassTagItem repetition) {
    setState(() {
      if (repetition.title == "Once") {
        isOccurringOnce = true;
        newXtra.occurs = "once";
      }
      if (repetition.title == "Repeating") {
        isOccurringOnce = false;
        newXtra.occurs = "repeating";
      }
      if (repetition.title == "Rotational") {
        isOccurringOnce = false;
        newXtra.occurs = "rotational";
      }
    });
  }

  void _extraTypeSelected(ClassTagItem taskType) {
    newXtra.eventType = taskType.title.toLowerCase();
    // print("Selected task1: ${taskType.title}");
  }

  void _selectedDates(DateTime date, bool isDateFrom) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    if (isDateFrom) {
      newXtra.startDate = formattedDate;
    } else {
      newXtra.endDate = formattedDate;
    }
  }

  void _textInputAdded(String input) {
    newXtra.name = input;
    //print("Selected subject6: ${input}");
  }

  void _photoAdded(String path) {
    newXtra.newImagePath = path;
  }

  void _classDaysSelected(List<ClassTagItem> days) {
    List<String> daysList = [];
    for (var dayItem in days) {
      if (dayItem.selected) {
        daysList.add(dayItem.title.toLowerCase());
      }
      //print("Selected repetitionMode: ${dayItem.selected}");
    }
    newXtra.days = daysList;
    // print("Selected repetitionMode3: ${days}");
  }

  void _selectedTimes(TimeOfDay time, bool isTimeFrom) {
    final localizations = MaterialLocalizations.of(context);
    final formattedTimeOfDay =
        localizations.formatTimeOfDay(time, alwaysUse24HourFormat: true);

    if (isTimeFrom) {
      newXtra.startTime = formattedTimeOfDay;
    } else {
      newXtra.endTime = formattedTimeOfDay;
    }
  }

  void _saveClass() {
    widget.saveXtra(newXtra);
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        color: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        child: ListView.builder(
            controller: scrollcontroller,
            padding: const EdgeInsets.only(top: 30),
            itemCount: 7,
            itemBuilder: (context, index) {
              if (index == 10) {
                // Save/Cancel Buttons
                return Padding(
                  padding: const EdgeInsets.only(top: 32, bottom: 32),
                  // child: RoundedElevatedButton(
                  //     getAllTextInputs, widget.saveButtonTitle, 28),
                );
              } else {
                // Add Questions
                return Column(
                  children: [
                    if (index == 0) ...[
                      // Select Subject
                      SelectExtraType(
                        subjectSelected: _extraTypeSelected,
                      )
                    ],
                    Container(
                      height: 14,
                    ),
                    if (index == 1) ...[
                      // Switch Start dates
                      HolidayTextImputs(
                        formsFilled: _textInputAdded,
                        hintText: 'Name',
                        labelTitle: 'Name*',
                      )
                    ],
                    if (index == 2) ...[
                      // Select Ocurring
                      ClassRepetition(
                        subjectSelected: _xtraOccuringSelected,
                      )
                    ],
                    if (index == 3) ...[
                      // Select Week days
                      // ClassWeekDays(
                      //   subjectSelected: _classDaysSelected,
                      // ),

                      if (!isOccurringOnce) ...[
                        // Select Week days
                        ClassWeekDays(
                          xtraItem: newXtra,
                          subjectSelected: _classDaysSelected,
                        )
                      ],
                      if (isOccurringOnce) ...[
                        SelectTimes(
                          xtraItem: newXtra,
                          timeSelected: _selectedTimes,
                        )
                      ],
                    ],
                    if (index == 4) ...[
                      // Select Time From/To
                      // SelectTimes(
                      //   timeSelected: _selectedTimes,
                      // )
                      if (!isOccurringOnce) ...[
                        // Select Time From/To
                        SelectTimes(
                          xtraItem: newXtra,
                          timeSelected: _selectedTimes,
                        )
                      ],
                      if (isOccurringOnce) ...[
                        // Switch Start dates
                        RowSwitch(
                          title: "Add Start/end dates?",
                          isOn: isOccurringOnce ? true : addStartEndDates,
                          changedState: _switchChangedState,
                          index: 0,
                        )
                      ]
                    ],
                    if (index == 5) ...[
                      if (!isOccurringOnce) ...[
                        // Switch Start dates
                        RowSwitch(
                          title: "Add Start/end dates?",
                          isOn: isOccurringOnce ? true : addStartEndDates,
                          changedState: _switchChangedState,
                          index: 0,
                        )
                      ],
                      // if (isOccurringOnce) ...[
                      //   if (isOccurringOnce || addStartEndDates) ...[
                      //     if (index == 7) ...[
                      //       SelectDates(
                      //         xtraItem: newXtra,
                      //         dateSelected: _selectedDates,
                      //         shouldDisableEndDate: isOccurringOnce,
                      //       ),
                      //     ],
                      //   ]
                      // ]
                      // AddPhotoWidget(
                      //   photoAdded: () => {},
                      // )
                    ],
                    if (index == 6) ...[
                      if (isOccurringOnce || addStartEndDates) ...[
                        SelectDates(
                          xtraItem: newXtra,
                          dateSelected: _selectedDates,
                          shouldDisableEndDate: isOccurringOnce,
                        ),
                      ],
                      if (!isOccurringOnce || !addStartEndDates) ...[
                        AddPhotoWidget(
                          imageUrl: newXtra.newImagePath ?? newXtra.imageUrl,
                          photoAdded: _photoAdded,
                        )
                      ],
                    ],

                    // if (index == 5) ...[
                    //   // Select Subject
                    //   SelectTaskRepeatOptions(
                    //     repeatOptionSelected: _taskRepeatOptionSelected,
                    //     dateSelected: _tasRepeatDateSelect,
                    //   )
                    // ],
                    if (index == 6) ...[
                      // Save/Cancel buttons
                      Container(
                        height: 68,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        width: double.infinity,
                        // margin: const EdgeInsets.only(top: 260),
                        padding: const EdgeInsets.only(left: 106, right: 106),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RoundedElevatedButton(
                                _saveClass,
                                "Save Task",
                                Constants.lightThemePrimaryColor,
                                Colors.black,
                                45),
                            RoundedElevatedButton(
                                _cancel,
                                "Cancel",
                                Constants.blueButtonBackgroundColor,
                                Colors.white,
                                45)
                          ],
                        ),
                      ),
                      Container(
                        height: 88,
                      ),
                    ],
                  ],
                );
              }
            }),
      );
    });
  }
}
