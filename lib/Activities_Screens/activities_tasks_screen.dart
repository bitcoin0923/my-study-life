import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Networking/task_service.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import 'dart:convert';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';
import '../Models/Services/storage_service.dart';

import '../../app.dart';
import '.././Models/class_datasource.dart';
import '../Home_Screens/class_details_screen.dart';
import '../Widgets/ClassWidgets/class_widget.dart';
import '.././Widgets/exam_widget.dart';
import '../Models/exam_datasource.dart';
import '../Home_Screens/exam_details_screen.dart';
import './custom_segmentedcontrol.dart';
import '../Widgets/expandable_listview.dart';
import '../Activities_Screens/tasks_current.dart';
import '../Activities_Screens/tasks_past.dart';
import '../Activities_Screens/tasks_overdue.dart';
import '../Models/API/exam.dart';
import 'package:dio/dio.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Models/API/task.dart';
import '../Widgets/TaskWidgets/task_widget.dart';
import '../Models/API/subject.dart';

class ActivitiesTasksScreen extends StatefulWidget {
  const ActivitiesTasksScreen({super.key});

  @override
  State<ActivitiesTasksScreen> createState() => _ActivitiesTasksScreenState();
}

class _ActivitiesTasksScreenState extends State<ActivitiesTasksScreen> {
  final List<ClassSubject> _durations = ClassSubject.subjects;
  final List<ExamStatic> _exams = ExamStatic.exams;
  int selectedTabIndex = 1;

  String selectedSubject = "";
  final StorageService _storageService = StorageService();
  List<Task> _tasksCurrent = [];
  List<Task> _tasksPast = [];
  List<Task> _tasksOverdue = [];

  List<Task> _allTasksCurrent = [];
  List<Task> _allTasksPast = [];
  List<Task> _allTasksOverdue = [];

  List<Subject> _subjects = [];
  Map<int, List<Task>> groupedByDate = {};
  List<int> groupedKeys = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  void getData() async {
    var taskDataCurrent =
        await _storageService.readSecureData("user_tasks_current");

    List<dynamic> decodedDataTasksCurrent = jsonDecode(taskDataCurrent ?? "");

    var taskDataPast = await _storageService.readSecureData("user_tasks_past");

    List<dynamic> decodedDataTasksPast = jsonDecode(taskDataPast ?? "");

    var taskDataOverdue =
        await _storageService.readSecureData("user_tasks_past");

    List<dynamic> decodedDataTasksOverdue = jsonDecode(taskDataOverdue ?? "");

    // Get Tasks from storage
    var subjectsData = await _storageService.readSecureData("user_subjects");

    List<dynamic> decodedDataSubjects = jsonDecode(subjectsData ?? "");

    if (!context.mounted) return;

    setState(() {
      _allTasksCurrent = List<Task>.from(
        decodedDataTasksCurrent
            .map((x) => Task.fromJson(x as Map<String, dynamic>)),
      );

      _tasksCurrent = _allTasksCurrent;

      _allTasksPast = List<Task>.from(
        decodedDataTasksPast
            .map((x) => Task.fromJson(x as Map<String, dynamic>)),
      );

      _tasksPast = _allTasksPast;

      _allTasksOverdue = List<Task>.from(
        decodedDataTasksOverdue
            .map((x) => Task.fromJson(x as Map<String, dynamic>)),
      );

      _tasksOverdue = _allTasksOverdue;

      //_tasks = _allTasks;
      groupTasksByDate();

      _subjects = List<Subject>.from(
        decodedDataSubjects
            .map((x) => Subject.fromJson(x as Map<String, dynamic>)),
      );

      final names = _subjects.map((e) => e.subjectName).toSet();
      _subjects.retainWhere((x) => names.remove(x.subjectName));
      _subjects.insert(0, Subject(subjectName: "All Subjects"));

      selectedSubject = _subjects[0].subjectName ?? "";
    });
  }

  void filterTasks() {
    switch (selectedTabIndex) {
      case 1:
        if (selectedSubject != "All Subjects") {
          _tasksCurrent = _allTasksCurrent.where((e) {
            final subject = e.subject?.subjectName;

            return subject == selectedSubject;
          }).toList();
        } else {
          _tasksCurrent = _allTasksCurrent;
        }
        break;
      case 2:
        if (selectedSubject != "All Subjects") {
          _tasksPast = _allTasksPast.where((e) {
            final subject = e.subject?.subjectName;

            return subject == selectedSubject;
          }).toList();
          groupTasksByDate();
        } else {
          _tasksPast = _allTasksPast;
          groupTasksByDate();
        }
        break;
      case 3:
        if (selectedSubject != "All Subjects") {
          _tasksOverdue = _allTasksOverdue.where((e) {
            final subject = e.subject?.subjectName;

            return subject == selectedSubject;
          }).toList();
        } else {
          _tasksOverdue = _allTasksOverdue;
        }
        break;
      default:
    }
  }

  void groupTasksByDate() {
    groupedKeys = [];
    groupedByDate =
        groupBy(_tasksPast, (obj) => obj.getTaskDueDateTime().month);
    groupedByDate.forEach((date, list) {
      // Header
      groupedKeys.add(date);
    });
  }

  void _selectedExamCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExamDetailsScreen(
                  examItem: Exam(),
                ),
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
                  'Current (${_tasksCurrent.length})',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
                2: Text(
                  'Past (${_tasksPast.length})',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
                3: Text(
                  'Overdue (${_tasksOverdue.length})',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
              },
            ),
          ),

          Container(
            height: 45,
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 75),
            decoration: BoxDecoration(
              color:
                  theme == ThemeMode.light ? Colors.transparent : Colors.black,
              border: Border.all(
                width: 1,
                color: theme == ThemeMode.dark
                    ? Colors.transparent
                    : Colors.black.withOpacity(0.2),
              ),
              borderRadius: BorderRadius.circular(5),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton(
                  value: selectedSubject,
                  onChanged: (String? newValue) => setState(() {
                    selectedSubject = newValue ?? "";
                    filterTasks();
                  }),
                  items: _subjects
                      .map<DropdownMenuItem<String>>(
                          (Subject subjectItem) => DropdownMenuItem<String>(
                                value: subjectItem.subjectName,
                                child: Text(subjectItem.subjectName ?? ""),
                              ))
                      .toList(),
                  icon: const Icon(Icons.keyboard_arrow_down),
                ),
              ),
            ),
          ),
          // Check which tab is selected
          if (selectedTabIndex == 1) ...[
            TasksCurrentList(_tasksCurrent, context),
          ],
          if (selectedTabIndex == 2) ...[
            TasksPastList(groupedByDate, groupedKeys),
          ],
          if (selectedTabIndex == 3) ...[
            TasksOverdueList(_tasksOverdue, context),
          ]
        ],
      );
    });
  }
}
