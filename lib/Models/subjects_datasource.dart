import 'package:flutter/material.dart';

class ClassTagItem {
  final String title;
  bool selected;
  bool isAddNewCard;

  final int cardIndex;

  ClassTagItem({
    required this.title,
    required this.selected,
    required this.isAddNewCard,
    required this.cardIndex,
  });

  static List<ClassTagItem> subjects = [
    ClassTagItem(
        title: "Math", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Chemistry", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Biology", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "Physics", selected: false, isAddNewCard: false, cardIndex: 3),
    ClassTagItem(
        title: "Computer Science",
        selected: false,
        isAddNewCard: false,
        cardIndex: 4),
    ClassTagItem(
        title: "+ Add New", selected: false, isAddNewCard: true, cardIndex: 5),
  ];

  static List<ClassTagItem> subjectModes = [
    ClassTagItem(
        title: "In Person", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Online", selected: false, isAddNewCard: false, cardIndex: 1),
  ];

  static List<ClassTagItem> repetitionModes = [
    ClassTagItem(
        title: "Once", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Repeating", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Rotational",
        selected: false,
        isAddNewCard: false,
        cardIndex: 2),
  ];

  static List<ClassTagItem> classDays = [
    ClassTagItem(
        title: "Mon", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Tue", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Wed", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "Thu", selected: false, isAddNewCard: false, cardIndex: 3),
    ClassTagItem(
        title: "Fri", selected: false, isAddNewCard: false, cardIndex: 4),
    ClassTagItem(
        title: "Sat", selected: false, isAddNewCard: false, cardIndex: 5),
    ClassTagItem(
        title: "Sun", selected: false, isAddNewCard: false, cardIndex: 6)
  ];

  static List<ClassTagItem> lightDarkMode = [
    ClassTagItem(
        title: "Use System default",
        selected: false,
        isAddNewCard: false,
        cardIndex: 0),
    ClassTagItem(
        title: "On", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Off", selected: false, isAddNewCard: false, cardIndex: 2),
  ];

  static List<ClassTagItem> settingsDyasToDisplay = [
    ClassTagItem(
        title: " 1 ", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: " 2 ", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: " 3 ", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: " 4 ", selected: false, isAddNewCard: false, cardIndex: 3),
    ClassTagItem(
        title: " 5 ", selected: false, isAddNewCard: false, cardIndex: 4),
    ClassTagItem(
        title: " 6 ", selected: false, isAddNewCard: false, cardIndex: 5),
    ClassTagItem(
        title: " 7 ", selected: false, isAddNewCard: false, cardIndex: 6)
  ];

  static List<ClassTagItem> startWeek = [
    ClassTagItem(
        title: " A ", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: " B ", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: " C ", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: " D ", selected: false, isAddNewCard: false, cardIndex: 3),
    ClassTagItem(
        title: " E ", selected: false, isAddNewCard: false, cardIndex: 4),
    ClassTagItem(
        title: " F", selected: false, isAddNewCard: false, cardIndex: 5),
    ClassTagItem(
        title: " G ", selected: false, isAddNewCard: false, cardIndex: 6)
  ];

  static List<ClassTagItem> examTypes = [
    ClassTagItem(
        title: "Exam", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Quiz", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Test", selected: false, isAddNewCard: false, cardIndex: 2),
  ];

  static List<ClassTagItem> notificationReminderTimes = [
    ClassTagItem(
        title: "5 Minutes", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "15 Minutes",
        selected: false,
        isAddNewCard: false,
        cardIndex: 1),
    ClassTagItem(
        title: "30 Minutes",
        selected: false,
        isAddNewCard: false,
        cardIndex: 2),
    ClassTagItem(
        title: "30 Minutes",
        selected: false,
        isAddNewCard: false,
        cardIndex: 2),
    ClassTagItem(
        title: "1 Day", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "2 Days", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "3 Days", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "4 Days", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "5 Days", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "6 Days", selected: false, isAddNewCard: false, cardIndex: 2),
  ];

  static List<ClassTagItem> taskTypes = [
    ClassTagItem(
        title: "Assignment",
        selected: false,
        isAddNewCard: false,
        cardIndex: 0),
    ClassTagItem(
        title: "Reminder", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Revision", selected: false, isAddNewCard: false, cardIndex: 2),
    ClassTagItem(
        title: "Essay", selected: false, isAddNewCard: false, cardIndex: 3),
    ClassTagItem(
        title: "Group Project",
        selected: false,
        isAddNewCard: false,
        cardIndex: 4),
    ClassTagItem(
        title: "Reading", selected: false, isAddNewCard: false, cardIndex: 5),
    ClassTagItem(
        title: "Meeting", selected: false, isAddNewCard: false, cardIndex: 6),
  ];

  static List<ClassTagItem> taskOccuring = [
    ClassTagItem(
        title: "Once", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Every Day", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Every Other Day",
        selected: false,
        isAddNewCard: false,
        cardIndex: 2),
    ClassTagItem(
        title: "Every 3 Days",
        selected: false,
        isAddNewCard: false,
        cardIndex: 3),
    ClassTagItem(
        title: "Every 4 Days",
        selected: false,
        isAddNewCard: false,
        cardIndex: 4),
    ClassTagItem(
        title: "Every 5 Days",
        selected: false,
        isAddNewCard: false,
        cardIndex: 5),
    ClassTagItem(
        title: "Every 6 Days",
        selected: false,
        isAddNewCard: false,
        cardIndex: 6),
    ClassTagItem(
        title: "Weekly", selected: false, isAddNewCard: false, cardIndex: 7),
    ClassTagItem(
        title: "Every Other Week",
        selected: false,
        isAddNewCard: false,
        cardIndex: 8),
    ClassTagItem(
        title: "Monthly", selected: false, isAddNewCard: false, cardIndex: 9),
  ];

  static List<ClassTagItem> taskRepeatOptions = [
    ClassTagItem(
        title: "End on a Specific Date",
        selected: false,
        isAddNewCard: false,
        cardIndex: 0),
    ClassTagItem(
        title: "Forever", selected: false, isAddNewCard: false, cardIndex: 1),
  ];

  static List<ClassTagItem> extraEventType = [
    ClassTagItem(
        title: "Academic", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Non-Academic",
        selected: false,
        isAddNewCard: false,
        cardIndex: 1),
  ];

  static List<ClassTagItem> scoreTypes = [
    ClassTagItem(
        title: "%", selected: false, isAddNewCard: false, cardIndex: 0),
    ClassTagItem(
        title: "Number", selected: false, isAddNewCard: false, cardIndex: 1),
    ClassTagItem(
        title: "Letter Grade",
        selected: false,
        isAddNewCard: false,
        cardIndex: 1),
  ];

  static List<ClassTagItem> dateTypes = [
    ClassTagItem(
        title: "Jan 1, 2022",
        selected: true,
        isAddNewCard: false,
        cardIndex: 0),
    ClassTagItem(
        title: "1 Jan, 2022",
        selected: false,
        isAddNewCard: false,
        cardIndex: 1),
    ClassTagItem(
        title: "2022, Jan 1",
        selected: false,
        isAddNewCard: false,
        cardIndex: 2),
  ];
  static List<ClassTagItem> timeTypes = [
    ClassTagItem(
        title: "12 hrs (Eg 3pm)",
        selected: true,
        isAddNewCard: false,
        cardIndex: 0),
    ClassTagItem(
        title: "24 hrs (Eg 15:00)",
        selected: false,
        isAddNewCard: false,
        cardIndex: 1),
  ];

  static List<ClassTagItem> academicIntervals = [
    ClassTagItem(
        title: "Semesters",
        selected: true,
        isAddNewCard: false,
        cardIndex: 0),
    ClassTagItem(
        title: "Terms",
        selected: false,
        isAddNewCard: false,
        cardIndex: 1),
  ];
  static List<ClassTagItem> taughtSessions = [
    ClassTagItem(
        title: "Lessons",
        selected: true,
        isAddNewCard: false,
        cardIndex: 0),
    ClassTagItem(
        title: "Classes",
        selected: false,
        isAddNewCard: false,
        cardIndex: 1),
  ];
  static List<ClassTagItem> taughtSedaysOffssions = [
    ClassTagItem(
        title: "Holidays",
        selected: true,
        isAddNewCard: false,
        cardIndex: 0),
    ClassTagItem(
        title: "Vacations",
        selected: false,
        isAddNewCard: false,
        cardIndex: 1),
         ClassTagItem(
        title: "Days Off",
        selected: false,
        isAddNewCard: false,
        cardIndex: 1),
  ];
}

class SubjectListItem {
  final String title;
  final Color subjectColor;
  final String subjectImage;

  final int cardIndex;

  SubjectListItem({
    required this.subjectImage,
    required this.title,
    required this.subjectColor,
    required this.cardIndex,
  });

  static List<SubjectListItem> subjectsList = [
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 0,
        title: "Chemistry",
        subjectColor: Colors.green),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 1,
        title: "Maths",
        subjectColor: Colors.red),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 2,
        title: "Biology",
        subjectColor: Colors.purple),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 3,
        title: "Genetic Mutations",
        subjectColor: Colors.yellow),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 0,
        title: "Chemistry",
        subjectColor: Colors.green),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 1,
        title: "Maths",
        subjectColor: Colors.red),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 2,
        title: "Biology",
        subjectColor: Colors.purple),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 3,
        title: "Genetic Mutations",
        subjectColor: Colors.yellow),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 0,
        title: "Chemistry",
        subjectColor: Colors.green),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 1,
        title: "Maths",
        subjectColor: Colors.red),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 2,
        title: "Biology",
        subjectColor: Colors.purple),
    SubjectListItem(
        subjectImage: "assets/images/ChemistryClassImage.png",
        cardIndex: 3,
        title: "Genetic Mutations",
        subjectColor: Colors.yellow),
  ];
}
