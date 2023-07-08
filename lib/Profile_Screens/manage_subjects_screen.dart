import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';

import '../../app.dart';
import '../Utilities/constants.dart';
import '../Models/subjects_datasource.dart';
import '../Widgets/rounded_elevated_button.dart';
import '../Widgets/ProfileWidgets/manage_subject_card.dart';
import './new_subject_screen.dart';
import '../Models/Services/storage_service.dart';
import '../Models/API/subject.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Widgets/loaderIndicator.dart';
import '../Networking/subject_service.dart';
import 'package:dio/dio.dart';
import '../Models/Services/storage_service.dart';
import '../Models/Services/storage_item.dart';

class ManageSubjectsScreen extends StatefulWidget {
  const ManageSubjectsScreen({super.key});

  @override
  State<ManageSubjectsScreen> createState() => _ManageSubjectsScreenState();
}

class _ManageSubjectsScreenState extends State<ManageSubjectsScreen> {
  final List<SubjectListItem> _items = SubjectListItem.subjectsList;
  final StorageService _storageService = StorageService();
  List<Subject> _subjects = [];

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () {
      getSubjects();
    });
  }

  Future _refreshSubjects() async {
    try {
      var subjectsResponse = await SubjectService().getSubjects();

      setState(() {
        final subjectsList = (subjectsResponse.data['subjects']) as List;
        _subjects = subjectsList.map((i) => Subject.fromJson(i)).toList();
        _storageService.writeSecureData(
            StorageItem("user_subjects", jsonEncode(_subjects)));
      });

      // for (var subject in subjects) {
      //   print("SUBJECtS ${subject.subjectName}");
      // }
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

  void getSubjects() async {
    var subjectsData = await _storageService.readSecureData("user_subjects");

    List<dynamic> decodedDataSubjects = jsonDecode(subjectsData ?? "");

    setState(() {
      _subjects = List<Subject>.from(
        decodedDataSubjects
            .map((x) => Subject.fromJson(x as Map<String, dynamic>)),
      );
    });
  }

  void _addSubjectTapped() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const AddSubjectScreen(),
            fullscreenDialog: true));
  }

  void _subjectCardSelected(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => AddSubjectScreen(
                  editedSubject: _subjects[index],
                ),
            fullscreenDialog: true));
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
            "Manage Subjects",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: RefreshIndicator(
            onRefresh: () async {
              return _refreshSubjects();
            },
            edgeOffset: 100,
            child: Container(
              height: double.infinity,
              margin: const EdgeInsets.only(left: 20, right: 20, top: 8),
              child: Stack(
                children: [
                  Container(
                    height: 60,
                    margin: EdgeInsets.only(top: 8),
                    child: RoundedElevatedButton(
                        _addSubjectTapped,
                        "+ Add new subject",
                        Constants.lightThemePrimaryColor,
                        Colors.black,
                        50),
                  ),
                  Container(
                    //height: double.infinity,
                    margin: EdgeInsets.only(top: 76),

                    child: ListView.builder(
                      // controller: widget._controller,
                      itemCount: _subjects.length,
                      itemBuilder: (context, index) {
                        return ManageSubjectCard(
                            subjectItem: _subjects[index],
                            cardIndex: index,
                            cardselected: _subjectCardSelected);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
