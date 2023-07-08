import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../ClassWidgets/select_subject.dart';
import '../../Models/subjects_datasource.dart';
import '../ClassWidgets/select_class_mode.dart';
import '../ClassWidgets/class_text_imputs.dart';
import '../ClassWidgets/select_times.dart';
import '../ClassWidgets/class_days.dart';
import '../rounded_elevated_button.dart';
import '../switch_row_widget.dart';
import '../ClassWidgets/select_exam_type.dart';
import 'exam_text_imputs.dart';
import 'exam_datetime_duration.dart';

import '../../Models/Services/storage_service.dart';
import '../../Models/API/subject.dart';
import '../../Models/API/exam.dart';

class CreateExam extends StatefulWidget {
  final Function saveExam;
  final Exam? editedExam;
  const CreateExam({super.key, required this.saveExam, this.editedExam});

  @override
  State<CreateExam> createState() => _CreateExamState();
}

class _CreateExamState extends State<CreateExam> {
  final ScrollController scrollcontroller = ScrollController();
  final StorageService _storageService = StorageService();
  static List<Subject> _subjects = [];
  late Exam newExam = Exam(mode: "in-person", duration: 30);

  bool isExamInPerson = true;
  bool resitOn = false;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    checkForEditedExam();
    Future.delayed(Duration.zero, () {
      getSubjects();
    });
  }

  @override
  void dispose() {
    newExam = Exam(mode: "in-person");
    isExamInPerson = true;
    resitOn = false;
    isEditing = false;
    super.dispose();
  }

  void checkForEditedExam() {
    if (widget.editedExam != null) {
      isEditing = true;
      newExam = widget.editedExam!;
      newExam.duration = 30;

      if (newExam.mode != "in-person") {
        isExamInPerson = false;
      }

      if (newExam.resit != null) {
        resitOn = newExam.resit ?? false;
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
        var selectedSubjectIndex = _subjects.indexWhere((element) =>
            element.id == int.parse(widget.editedExam?.subjectId ?? ""));
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
        newExam.subject = savedSubject;
      }
    }
    // print("Selected subject: ${subject.subjectName}");
  }

  void _examModeSelected(ClassTagItem mode) {
    setState(() {
      if (mode.title == "In Person") {
        isExamInPerson = true;
        newExam.mode = "in-person";
      } else {
        isExamInPerson = false;
        newExam.mode = "online";
      }
    });
  }

  void _textInputAdded(String text, TextFieldType type) {
    print(text);
    switch (type) {
      case TextFieldType.moduleName:
        newExam.module = text;
        break;
      case TextFieldType.seatName:
        newExam.seat = text;
        break;
      case TextFieldType.roomName:
        newExam.room = text;
        break;
      case TextFieldType.onlineURL:
        newExam.onlineUrl = text;
        break;
      default:
    }
  }

  void _examTypeSelected(ClassTagItem type) {
    newExam.type = type.title.toLowerCase();
    // print("Selected repetitionMode: ${type.title}");
  }

  void _switchChangedState(bool isOn, int index) {
    setState(() {
      resitOn = isOn;
      print("Swithc isOn : $isOn");
    });
  }

  void _dateOfExamSelected(
    DateTime date,
  ) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    newExam.startDate = formattedDate;
  }

  void _timeOfExamSelected(
    TimeOfDay time,
  ) {
    final localizations = MaterialLocalizations.of(context);
    final formattedTimeOfDay =
        localizations.formatTimeOfDay(time, alwaysUse24HourFormat: true);

    newExam.startTime = formattedTimeOfDay;
  }

  void _classDaysSelected(List<ClassTagItem> days) {
    // print("Selected repetitionMode: ${days}");
    List<String> daysList = [];
    for (var dayItem in days) {
      daysList.add(dayItem.title.toLowerCase());
    }
  }

  void _durationOfExamSelected(String duration) {
    int intValue = int.parse(duration.replaceAll(RegExp('[^0-9]'), ''));
    newExam.duration = intValue;
  }

  void _saveExam() {
    widget.saveExam(newExam);
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
                      //Select Subject
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
                      // Switch Start dates
                      RowSwitch(
                          title: "Resit",
                          isOn: resitOn,
                          changedState: _switchChangedState, index: 0,)
                    ],
                    if (index == 2) ...[
                      SelectExamType(
                          subjectSelected: _examTypeSelected,
                          type: newExam.type)
                    ],
                    if (index == 3) ...[
                      // Select Mode
                      SelectClassMode(
                        subjectSelected: _examModeSelected,
                        isClassInPerson: isExamInPerson,
                      )
                    ],
                    if (index == 4) ...[
                      // Add Text Descriptions
                      ExamTextImputs(
                        textInputAdded: _textInputAdded,
                        isExamInPerson: isExamInPerson,
                        examItem: isEditing ? newExam : null,
                      )
                    ],
                    if (index == 5) ...[
                      // Select Day,Time, Duration
                      ExamDateTimeDuration(
                          examItem: isEditing ? newExam : null,
                          dateSelected: _dateOfExamSelected,
                          timeSelected: _timeOfExamSelected,
                          durationSelected: _durationOfExamSelected),
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
                                _saveExam,
                                "Save Exam",
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
