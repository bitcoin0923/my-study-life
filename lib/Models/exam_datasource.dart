import 'package:flutter/material.dart';

class ExamStatic {
  final String title;
  final String description;
  final DateTime dateFrom;
  final String subjectImage;
  final int tasksDue;
  final bool upNext;
  final Color subjectColor;
  final Duration duration;
  final String examType;

  Image? classImage;

  ExamStatic({
    required this.title,
    required this.description,
    required this.dateFrom,
    required this.subjectColor,
    required this.subjectImage,
    required this.tasksDue,
    required this.upNext,
    this.classImage,
    required this.duration,
    required this.examType,
  });

  static List<ExamStatic> exams = [
    ExamStatic(
        title: "Biology",
        description: "Redox Reactions",
        dateFrom: DateTime.now().add(Duration(days: 3)),
        subjectImage: 'assets/images/BiologyExample.png',
        tasksDue: 2,
        upNext: false,
        subjectColor: Colors.cyan,
        duration: Duration(minutes: 60),
        examType: 'Quiz'),
    ExamStatic(
        title: "Biology",
        description: "Redox Reactions",
        dateFrom: DateTime.now().add(Duration(days: 3)),
        subjectImage: 'assets/images/BiologyExample.png',
        tasksDue: 2,
        upNext: false,
        subjectColor: Colors.cyan,
        duration: Duration(minutes: 60),
        examType: 'Quiz'),
    ExamStatic(
        title: "Biology",
        description: "Redox Reactions",
        dateFrom: DateTime.now().add(Duration(days: 3)),
        subjectImage: 'assets/images/BiologyExample.png',
        tasksDue: 2,
        upNext: false,
        subjectColor: Colors.cyan,
        duration: Duration(minutes: 60),
        examType: 'Quiz'),
    ExamStatic(
        title: "Biology",
        description: "Redox Reactions",
        dateFrom: DateTime.now().add(Duration(days: 3)),
        subjectImage: 'assets/images/BiologyExample.png',
        tasksDue: 2,
        upNext: false,
        subjectColor: Colors.cyan,
        duration: Duration(minutes: 60),
        examType: 'Quiz'),
    ExamStatic(
        title: "Biology",
        description: "Redox Reactions",
        dateFrom: DateTime.now().add(Duration(days: 3)),
        subjectImage: 'assets/images/BiologyExample.png',
        tasksDue: 2,
        upNext: false,
        subjectColor: Colors.cyan,
        duration: Duration(minutes: 60),
        examType: 'Quiz'),
  ];
}

class ExamDuration {
  final String title;
  final int duration;

  ExamDuration({
    required this.title,
    required this.duration,
  });

    static List<ExamDuration> durations = [
      ExamDuration(title: "30 minutes", duration: 30),
      ExamDuration(title: "60 minutes", duration: 60),
      ExamDuration(title: "90 minutes", duration: 90),
      ExamDuration(title: "120 minutes", duration: 120),
    ];
}
