import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Models/Services/storage_service.dart';
import 'dart:convert';
import "package:collection/collection.dart";
import 'package:intl/intl.dart';

import '../../app.dart';
import '../Home_Screens/exam_details_screen.dart';
import './custom_segmentedcontrol.dart';
import '../Widgets/expandable_listview.dart';
import '../Models/API/exam.dart';
import '../Models/API/subject.dart';
import '../Networking/exam_service.dart';
import 'package:dio/dio.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/custom_snack_bar.dart';

class ActivitiesExamsScreen extends StatefulWidget {
  const ActivitiesExamsScreen({super.key});

  @override
  State<ActivitiesExamsScreen> createState() => _ActivitiesExamsScreenState();
}

class _ActivitiesExamsScreenState extends State<ActivitiesExamsScreen> {
  final ScrollController scrollcontroller = ScrollController();
  //final List<ClassSubject> _durations = ClassSubject.subjects;
  String selectedSubject = "";
  final StorageService _storageService = StorageService();
  List<Exam> _exams = [];
  List<Exam> _allExams = [];
  List<Subject> _subjects = [];
  Map<int, List<Exam>> groupedByDate = {};
  List<int> groupedKeys = [];

  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      getData();
    });
  }

  void getData() async {
    var examsData = await _storageService.readSecureData("user_exams_all");

    List<dynamic> decodedDataExams = jsonDecode(examsData ?? "");

    // Get Tasks from storage
    var subjectsData = await _storageService.readSecureData("user_subjects");

    List<dynamic> decodedDataSubjects = jsonDecode(subjectsData ?? "");

    if (!context.mounted) return;

    setState(() {
      _allExams = List<Exam>.from(
        decodedDataExams.map((x) => Exam.fromJson(x as Map<String, dynamic>)),
      );

      _exams = _allExams;
      groupExamsByDate();

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

  // API
  Future _getFilteredExams(String filter) async {
    //  DateTime dateTo = date.add(Duration(days: 1));

    LoadingDialog.show(context);

    try {
      var examsResponse = await ExamService().getExams(null, filter);

      if (!context.mounted) return;

      LoadingDialog.hide(context);

      setState(() {
        final examList = (examsResponse.data['exams']) as List;
        _exams = examList.map((i) => Exam.fromJson(i)).toList();
        groupExamsByDate();
      });
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], false);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", false);
      }
    }
  }

  String getMonthName(int monthNumber) {
    var currentDate = DateTime.now();
    var currentMonth = currentDate.month;
    String formattedDate = DateFormat('MMM, yyyy').format(currentDate);
    String formattedYear = DateFormat('yyyy').format(currentDate);

    if (monthNumber == currentMonth) {
      return "Earlier this month - $formattedDate";
    } else {
      switch (monthNumber) {
        case 1:
          return "Jan, $formattedYear                                 ";
        case 2:
          return "Feb, $formattedYear                                 ";
        case 3:
          return "Mar, $formattedYear                                 ";
        case 4:
          return "Apr, $formattedYear                                 ";
        case 5:
          return "May, $formattedYear                                 ";
        case 6:
          return "Jun, $formattedYear                                 ";
        case 7:
          return "Jul, $formattedYear                                 ";
        case 8:
          return "Aug, $formattedYear                                 ";
        case 9:
          return "Sep, $formattedYear                                 ";
        case 10:
          return "Oct, $formattedYear                                 ";
        case 11:
          return "Nov, $formattedYear                                 ";
        case 12:
          return "Dec, $formattedYear                                 ";

        default:
          formattedYear;
      }
    }
    return formattedYear;
  }

  void filterExams() {
    if (selectedSubject != "All Subjects") {
      _exams = _allExams.where((e) {
        final subject = e.subject?.subjectName;

        return subject == selectedSubject;
      }).toList();
      groupExamsByDate();
    } else {
      _exams = _allExams;
      groupExamsByDate();
    }
  }

  void groupExamsByDate() {
    groupedKeys = [];
    groupedByDate =
        groupBy(_exams, (obj) => obj.getExamStartdateDateTime().month);
    groupedByDate.forEach((date, list) {
      // Header
      groupedKeys.add(date);
    });
  }

  void _selectedTabWithIndex(int index) {
    setState(() {
      selectedTabIndex = index;
      if (selectedTabIndex == 1) {
        _getFilteredExams("current");
      }
       if (selectedTabIndex == 2) {
        _getFilteredExams("past");
      }
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
                  'Current',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextSelectedStyle,
                ),
                2: Text(
                  'Past',
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
                    filterExams();
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
          // Exams
          Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 156),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return ExpandableListView(
                  period: getMonthName(groupedKeys.reversed.toList()[index]),
                  numberOfItems:
                      "${groupedByDate[groupedKeys.toList()[index]]?.length}",
                  exams: groupedByDate[groupedKeys[index]],
                );
              },
              itemCount: groupedKeys.reversed.length,
            ),
          ),
        ],
      );
    });
  }
}
