import 'package:flutter/material.dart';

class TaskItem {
  final String title;
  final String subject;
  final String type;
  final DateTime date;
  final String subjectImage;
  final int progress;
  final Color subjectColor;

  int? overdueDays;

  TaskItem(
      {required this.title,
      required this.subject,
      required this.type,
      required this.date,
      required this.subjectImage,
      required this.progress,
      required this.subjectColor,
      this.overdueDays});

  static List<TaskItem> tasks = [
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red),
  ];

  static List<TaskItem> thisMonthTasks = [
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red),
            TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.blue),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now().add(Duration(days: 3)),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now().add(Duration(days: 5)),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now().add(Duration(days: 15)),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red,),
  ];

    static List<TaskItem> overdueTasks = [
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 2,
        subjectColor: Colors.red,
        overdueDays: 3),
            TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now(),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 4,
        subjectColor: Colors.blue,
        overdueDays: 4),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now().add(Duration(days: 3)),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red,
        overdueDays: 4),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now().add(Duration(days: 5)),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red,
        overdueDays: 4),
    TaskItem(
        title: "Diagrams on flower structures and anatomy",
        subject: "Biology",
        type: "Assignment",
        date: DateTime.now().add(Duration(days: 15)),
        subjectImage: "assets/images/ChemistryClassImage.png",
        progress: 5,
        subjectColor: Colors.red,
        overdueDays: 5),
  ];
}
