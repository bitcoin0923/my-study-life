import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../ClassWidgets/select_subject.dart';
import '../../Models/subjects_datasource.dart';
import '../rounded_elevated_button.dart';
import '../TaskWidgets/task_text_imputs.dart';
import './task_datetime.dart';
import './select_tasktype.dart';
import './select_taskOccuring.dart';
import './select_repeatOptions.dart';
import '../../Models/API/task.dart';

class CreateTask extends StatefulWidget {
  final Function saveTask;
  final Task? taskitem;
  const CreateTask({super.key, required this.saveTask, this.taskitem});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final ScrollController scrollcontroller = ScrollController();

  late Task newTask = Task();
  bool isEditing = false;

  @override
  void initState() {
    checkForEditedTask();
    super.initState();
  }

  @override
  void dispose() {
    newTask = Task();
    isEditing = false;
    super.dispose();
  }

  void checkForEditedTask() {
    if (widget.taskitem != null) {
      isEditing = true;
      newTask = widget.taskitem!;
    }
  }

  void _taskTypeSelected(ClassTagItem taskType) {
   // print("Selected task: ${taskType.title}");
    newTask.type = taskType.title.toLowerCase();
  }

  void _titleAdded(String text) {
    newTask.title = text;
  }

  void _detailsAdded(String text) {
    newTask.details = text;
  }

  void _taskOccuringSelected(ClassTagItem occuring) {
    newTask.occurs = occuring.title.toLowerCase();
   // print("Selected repetitionMode: ${occuring.title}");
  }

  void _dateOfTaskSelected(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    newTask.dueDate = formattedDate;
  }

  void _taskRepeatOptionSelected(ClassTagItem repeatOption) {
    newTask.repeatOption = repeatOption.title.toLowerCase();
   // print("Selected task: ${repeatOption.title}");
  }

  void _tasRepeatDateSelect(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    newTask.endDate = formattedDate;
  }

  void _timeOfTaskelected(TimeOfDay time) {
    final localizations = MaterialLocalizations.of(context);
    final formattedTimeOfDay =
        localizations.formatTimeOfDay(time, alwaysUse24HourFormat: true);

    // newTask.startTime = formattedTimeOfDay;
  }

  void _saveClass() {
    widget.saveTask(newTask);
  }

  void _cancel() {
     Navigator.pop(context);
  }

  //  void _selectedTimes(TimeOfDay time, bool isTimeFrom) {
  //   final localizations = MaterialLocalizations.of(context);
  //   final formattedTimeOfDay =
  //       localizations.formatTimeOfDay(time, alwaysUse24HourFormat: true);

  //   if (isTimeFrom) {
  //     newClass.startTime = formattedTimeOfDay;
  //   } else {
  //     newClass.endTime = formattedTimeOfDay;
  //   }
  // }

  // void _selectedDates(DateTime date, bool isDateFrom) {
  //   String formattedDate = DateFormat('yyyy-MM-dd').format(date);
  //   if (isDateFrom) {
  //     newClass.startDate = formattedDate;
  //   } else {
  //     newClass.endDate = formattedDate;
  //   }
  //   print("Selected date: ${date} & ${isDateFrom}");
  // }

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
                      // SelectSubject(
                      //   subjectSelected: _subjectSelected,
                      // )
                    ],
                    Container(
                      height: 14,
                    ),
                    if (index == 1) ...[
                      // Switch Start dates
                      TaskTextImputs(
                        titleFormFilled: _titleAdded,
                        detailsFormFilled: _detailsAdded,
                        labelTitle: 'Title*',
                        hintText: 'Task Title',
                      ),
                    ],
                    if (index == 2) ...[
                      // Select Day,Time, Duration
                      TaskDateTime(
                          dateSelected: _dateOfTaskSelected,
                          timeSelected: _timeOfTaskelected),
                    ],
                    if (index == 3) ...[
                      // Select Subject
                      SelectTaskType(
                        taskSelected: _taskTypeSelected,
                      )
                    ],
                    if (index == 4) ...[
                      // Select Subject
                      SelectTaskOccuring(
                        occuringSelected: _taskOccuringSelected,
                      )
                    ],
                    if (index == 5) ...[
                      // Select Subject
                      SelectTaskRepeatOptions(
                        repeatOptionSelected: _taskRepeatOptionSelected,
                        dateSelected: _tasRepeatDateSelect,
                      )
                    ],
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
