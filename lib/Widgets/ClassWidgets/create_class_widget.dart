import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import 'select_subject.dart';
import '../../Models/subjects_datasource.dart';
import './select_class_mode.dart';
import './class_text_imputs.dart';
import './class_repetition.dart';
import './select_times.dart';
import './class_days.dart';
import '.././rounded_elevated_button.dart';
import '../switch_row_widget.dart';
import './select_dates.dart';

import '../../Models/Services/storage_service.dart';
import '../../Models/API/subject.dart';
import '../../Models/API/classmodel.dart';

class CreateClass extends StatefulWidget {
  final Function saveClass;
  final ClassModel? editedClass;
  const CreateClass({super.key, required this.saveClass, this.editedClass});

  @override
  State<CreateClass> createState() => _CreateClassState();
}

class _CreateClassState extends State<CreateClass> {
  final ScrollController scrollcontroller = ScrollController();
  final StorageService _storageService = StorageService();
  static List<Subject> _subjects = [];
  late ClassModel newClass = ClassModel(occurs: "once", mode: "in-person");

  bool isClassInPerson = true;
  bool addStartEndDates = false;
  bool isOccurringOnce = true;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    checkForEditedClass();
    Future.delayed(Duration.zero, () {
      getSubjects();
    });
  }

  @override
  void dispose() {
    newClass = ClassModel(occurs: "once", mode: "in-person");
    isClassInPerson = true;
    addStartEndDates = false;
    isOccurringOnce = true;
    isEditing = false;
    super.dispose();
  }

  void checkForEditedClass() {
    if (widget.editedClass != null) {
      isEditing = true;
      newClass = widget.editedClass!;

      if (newClass.mode != "in-person") {
        isClassInPerson = false;
      }

      if (newClass.occurs != "once") {
        isOccurringOnce = false;
      }
    }
  }

  void getSubjects() async {
    var subjectsData = await _storageService.readSecureData("user_subjects");

    List<dynamic> decodedData = jsonDecode(subjectsData ?? "");

    setState(() {
      _subjects = List<Subject>.from(
        decodedData.map((x) => Subject.fromJson(x as Map<String, dynamic>)),
      );
      if (isEditing) {
        var selectedSubjectIndex = _subjects.indexWhere(
            (element) => element.id == widget.editedClass?.subject?.id);
        var selectedSubject = _subjects[selectedSubjectIndex];
        selectedSubject.selected = true;
        _subjects[selectedSubjectIndex] = selectedSubject;
      }
    });
  }

  void _subjectSelected(Subject subject) {
    for (var savedSubject in _subjects) {
      savedSubject.selected = false;
      if (savedSubject.id == subject.id) {
        savedSubject.selected = true;
        newClass.subject = savedSubject;
      }
    }
    // print("Selected subject: ${subject.subjectName}");
  }

  void _textInputAdded(String text, TextFieldType type) {
    print(text);
    switch (type) {
      case TextFieldType.moduleName:
        newClass.module = text;
        break;
      case TextFieldType.buildingName:
        newClass.building = text;
        break;
      case TextFieldType.onlineURL:
        newClass.onlineUrl = text;
        break;
      case TextFieldType.roomName:
        newClass.room = text;
        break;
      case TextFieldType.teacherName:
        newClass.teacher = text;
        break;
      case TextFieldType.techerEmail:
        newClass.teachersEmail = text;
        break;
      default:
    }
  }

  void _subjectModeSelected(ClassTagItem mode) {
    setState(() {
      if (mode.title == "In Person") {
        isClassInPerson = true;
        newClass.mode = "in-person";
      } else {
        isClassInPerson = false;
        newClass.mode = "online";
      }
    });
  }

  // void _TextInputAdded(String input) {
  //   print("Selected subject: ${input}");
  // }

  void _classRepetitionSelected(ClassTagItem repetition) {
    setState(() {
      if (repetition.title == "Once") {
        isOccurringOnce = true;
        newClass.occurs = "once";
      }
      if (repetition.title == "Repeating") {
        isOccurringOnce = false;
        newClass.occurs = "repeating";
      }
      if (repetition.title == "Rotational") {
        isOccurringOnce = false;
        newClass.occurs = "rotational";
      }
    });
  }

  void _selectedTimes(TimeOfDay time, bool isTimeFrom) {
    final localizations = MaterialLocalizations.of(context);
    final formattedTimeOfDay =
        localizations.formatTimeOfDay(time, alwaysUse24HourFormat: true);

    if (isTimeFrom) {
      newClass.startTime = formattedTimeOfDay;
    } else {
      newClass.endTime = formattedTimeOfDay;
    }
  }

  void _selectedDates(DateTime date, bool isDateFrom) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    if (isDateFrom) {
      newClass.startDate = formattedDate;
    } else {
      newClass.endDate = formattedDate;
    }
    print("Selected date: ${date} & ${isDateFrom}");
  }

  void _classDaysSelected(List<ClassTagItem> days) {
    List<String> daysList = [];
    for (var dayItem in days) {
      if (dayItem.selected) {
        daysList.add(dayItem.title.toLowerCase());
      }
      //print("Selected repetitionMode: ${dayItem.selected}");
    }
    newClass.days = daysList;
  }

  void _switchChangedState(bool isOn, int index) {
    setState(() {
      addStartEndDates = isOn;
      print("Swithc isOn : $isOn");
    });
  }

  void _saveClass() {
    widget.saveClass(newClass);
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          color: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          child: ListView.builder(
              controller: scrollcontroller,
              padding: const EdgeInsets.only(top: 30),
              itemCount: addStartEndDates ? 9 : 8,
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
                        SelectSubject(
                          subjectSelected: _subjectSelected,
                          subjects: _subjects,
                          tagtype: TagType.subjects,
                        )
                      ],
                      Container(
                        height: 14,
                      ),
                      if (index == 1) ...[
                        // Select Mode
                        SelectClassMode(
                          subjectSelected: _subjectModeSelected,
                          isClassInPerson: isClassInPerson,
                        )
                      ],
                      if (index == 2) ...[
                        // Add Text Descriptions
                        ClassTextImputs(
                          textInputAdded: _textInputAdded,
                          isClassInPerson: isClassInPerson,
                          classItem: newClass,
                        )
                      ],
                      if (index == 3) ...[
                        // Select Ocurring
                        ClassRepetition(
                          classItem: newClass,
                          subjectSelected: _classRepetitionSelected,
                        )
                      ],
                      if (index == 4) ...[
                        if (!isOccurringOnce) ...[
                          // Select Week days
                          ClassWeekDays(
                            classItem: newClass,
                            subjectSelected: _classDaysSelected,
                          )
                        ],
                        if (isOccurringOnce) ...[
                          SelectTimes(
                            classItem: newClass,
                            timeSelected: _selectedTimes,
                          )
                        ],
                      ],
                      if (index == 5) ...[
                        if (!isOccurringOnce) ...[
                          // Select Time From/To
                          SelectTimes(
                            classItem: newClass,
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
                      if (index == 6) ...[
                        if (!isOccurringOnce) ...[
                          // Switch Start dates
                          RowSwitch(
                            title: "Add Start/end dates?",
                            isOn: isOccurringOnce ? true : addStartEndDates,
                            changedState: _switchChangedState,
                            index: 0,
                          )
                        ],
                        if (isOccurringOnce) ...[
                          if (isOccurringOnce || addStartEndDates) ...[
                            if (index == 7) ...[
                              SelectDates(
                                classItem: newClass,
                                dateSelected: _selectedDates,
                                shouldDisableEndDate: isOccurringOnce,
                              ),
                            ],
                          ]
                        ]
                      ],
                      if (isOccurringOnce || addStartEndDates) ...[
                        if (index == 7) ...[
                          SelectDates(
                            classItem: newClass,
                            dateSelected: _selectedDates,
                            shouldDisableEndDate: isOccurringOnce,
                          ),
                        ],
                        if (index == 8) ...[
                          // Save/Cancel buttons
                          Container(
                            height: 68,
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            // margin: const EdgeInsets.only(top: 260),
                            padding:
                                const EdgeInsets.only(left: 106, right: 106),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RoundedElevatedButton(
                                    _saveClass,
                                    "Save Class",
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
                      if (!addStartEndDates) ...[
                        if (index == 7) ...[
                          // Save/Cancel buttons
                          Container(
                            height: 68,
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            // margin: const EdgeInsets.only(top: 260),
                            padding:
                                const EdgeInsets.only(left: 106, right: 106),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RoundedElevatedButton(
                                    _saveClass,
                                    "Save Class",
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
                    ],
                  );
                }
              }),
        ),
      );
    });
  }
}
