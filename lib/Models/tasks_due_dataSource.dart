import 'package:flutter/material.dart';

class TaskDueStatic {
  final String title;
  final String subject;
  final Color subjectColor;
  final DateTime dueDate;

  TaskDueStatic({
    required this.title,
    required this.subject,
    required this.subjectColor,
    required this.dueDate,
  });

  static List<TaskDueStatic> tasksDue = [
    TaskDueStatic(title: 'Equations related to vertical velocity measurements', subject: 'Chemistry Assignment', subjectColor: Colors.red, dueDate: DateTime.now()),
    TaskDueStatic(title: 'Equations related to vertical velocity measurements', subject: 'Chemistry paper work ', subjectColor: Colors.blue, dueDate: DateTime.now()),
    TaskDueStatic(title: 'Equations related to vertical velocity measurements', subject: 'Chemistry paper work ', subjectColor: Colors.blue, dueDate: DateTime.now()),

  ];
}
