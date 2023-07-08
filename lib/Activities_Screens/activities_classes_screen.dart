import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../Utilities/constants.dart';
// import '../Extensions/extensions.dart';
// import '../Widgets/loaderIndicator.dart';
// import '../Widgets/custom_snack_bar.dart';
// import '../Extensions/extensions.dart';
// import '../Networking/subject_service.dart';
// import 'package:dio/dio.dart';
import '../Models/Services/storage_service.dart';
import 'dart:convert';

import '../../app.dart';
import '../Models/API/subject.dart';
import '../Home_Screens/class_details_screen.dart';
import '../Widgets/ClassWidgets/class_widget.dart';
import '../Models/API/classmodel.dart';

class ActivitiesClassesScreen extends StatefulWidget {
  const ActivitiesClassesScreen({super.key});

  @override
  State<ActivitiesClassesScreen> createState() =>
      _ActivitiesClassesScreenState();
}

class _ActivitiesClassesScreenState extends State<ActivitiesClassesScreen> {
  String selectedSubject = "";
  List<ClassModel> _classes = [];
  List<ClassModel> _allClasses = [];
  final StorageService _storageService = StorageService();
  List<Subject> _subjects = [];

  int _page = 1;
  final int _limit = 20;
  bool _hasNextPage = true;
  bool _isFirstLoadRunning = false;
  bool _isLoadMoreRunning = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 500), () {
      getData();
    });
  }

  void getData() async {
    var classesData = await _storageService.readSecureData("user_classes_all");

    List<dynamic> decodedDataClasses = jsonDecode(classesData ?? "");

    // Get Tasks from storage
    var subjectsData = await _storageService.readSecureData("user_subjects");

    List<dynamic> decodedDataSubjects = jsonDecode(subjectsData ?? "");

    if (!context.mounted) return;

    setState(() {
      _allClasses = List<ClassModel>.from(
        decodedDataClasses
            .map((x) => ClassModel.fromJson(x as Map<String, dynamic>)),
      );

      _classes = _allClasses;

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

  void filterClasses() {
    if (selectedSubject != "All Subjects") {
      _classes = _allClasses.where((e) {
        final subject = e.subject?.subjectName;

        return subject == selectedSubject;
      }).toList();
    } else {
      _classes = _allClasses;
    }
  }

  void _selectedCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClassDetailsScreen(_classes[index]),
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
            width: double.infinity,
            margin: const EdgeInsets.only(left: 20, right: 20, top: 16),
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
                    filterClasses();
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
          // Classes
          Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 84),
            child: ListView.builder(
                // controller: widget._controller,
                itemCount: _classes.length,
                itemBuilder: (context, index) {
                  return ClassWidget(
                      classItem: _classes[index],
                      cardIndex: index,
                      upNext: true,
                      cardselected: _selectedCard);
                }),
          ),
        ],
      );
    });
  }
}
