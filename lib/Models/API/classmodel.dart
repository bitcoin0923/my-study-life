import 'package:intl/intl.dart';
import './subject.dart';
import './task.dart';

class ClassModel {
  int? id;
  int? userId;
  String? module;
  String? mode;
  String? room;
  String? building;
  String? onlineUrl;
  String? teacher;
  String? teachersEmail;
  String? occurs;
  List<String>? days;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? createdAt;
  String? updatedAt;
  Subject? subject;
  List<Task>? tasks;
  bool? upNext;

  // Calculated

  String getFormattedStartDate() {
    DateTime? createdAtDate = DateTime.tryParse(startDate ?? "");

    if (createdAtDate != null) {
      String formattedDate =
          DateFormat('EEE, d MMM, yyyy').format(createdAtDate);
      return formattedDate;
    } else {
      return "Fri, 4 Mar 2023";
    }
  }

  DateTime getFormattedStartingDate() {
    DateTime? createdAtDate = DateTime.tryParse(startDate ?? "");

    if (createdAtDate != null) {
      // String formattedDate =
      //     DateFormat('MM/dd/yyyy HH:mm:ss').format(createdAtDate);
      return createdAtDate;
    } else {
      return DateTime.now();
    }
  }

    DateTime getFormattedEndingDate() {
    DateTime? createdAtDate = DateTime.tryParse(endDate ?? "");

    if (createdAtDate != null) {
      // String formattedDate =
      //     DateFormat('MM/dd/yyyy HH:mm:ss').format(createdAtDate);
      return createdAtDate;
    } else {
      return DateTime.now();
    }
  }

  String getFormattedEndDate() {
    DateTime? createdAtDate = DateTime.tryParse(endDate ?? "");

    if (createdAtDate != null) {
      String formattedDate =
          DateFormat('EEE, d MMM, yyyy').format(createdAtDate);
      return formattedDate;
    } else {
      return "Fri, 4 Mar 2023";
    }
  }

  ClassModel(
      {this.id,
      this.userId,
      this.module,
      this.mode,
      this.room,
      this.building,
      this.onlineUrl,
      this.teacher,
      this.teachersEmail,
      this.occurs,
      this.days,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.subject,
      this.createdAt,
      this.updatedAt,
      this.tasks,
      this.upNext});

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    List<String> dayStrings = [];

    if (json['days'] != null) {
      List<dynamic> rawDays = json['days'];
      dayStrings = rawDays.map(
        (item) {
          return item as String;
        },
      ).toList();
    }

    final tasksList = json['tasks'] as List;
    List<Task> tasksFinal = tasksList.map((i) => Task.fromJson(i)).toList();

    return ClassModel(
        id: json['id'],
        userId: json['userId'],
        module: json['module'],
        mode: json['mode'],
        room: json['room'],
        building: json['building'],
        onlineUrl: json['onlineUrl'],
        teacher: json['teacher'],
        teachersEmail: json['teachersEmail'],
        occurs: json['occurs'],
        subject:
            json['subject'] != null ? Subject.fromJson(json['subject']) : null,
        days: dayStrings,
        startDate: json['startDate'],
        endDate: json['endDate'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        createdAt: json['created_at'],
        updatedAt: json['updated_at'],
        tasks: tasksFinal,
        upNext: json['upNext']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['userId'] = userId;
    data['module'] = module;
    data['mode'] = mode;
    data['room'] = room;
    data['building'] = building;
    data['onlineUrl'] = onlineUrl;
    data['days'] = days;
    data['teacher'] = teacher;
    data['teachersEmail'] = teachersEmail;
    data['occurs'] = occurs;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (tasks != null) {
      data['tasks'] = tasks;
    }
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    data['upNext'] = upNext;
    return data;
  }
}
