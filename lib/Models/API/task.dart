import './subject.dart';
import './exam.dart';
import 'package:intl/intl.dart';

class Task {
  int? id;
  int? userId;
  String? title;
  String? subjectId;
  int? examId;
  int? classId;
  String? details;
  String? type;
  int? progress;
  String? category;
  String? occurs;
  List<String>? days;
  String? dueDate;
  String? endDate;
  String? repeatOption;
  String? completedAt;
  String? createdAt;
  String? updatedAt;
  Subject? subject;
  Exam? exam;

  Task(
      {this.id,
      this.userId,
      this.subjectId,
      this.examId,
      this.classId,
      this.details,
      this.type,
      this.progress,
      this.category,
      this.occurs,
      this.days,
      this.dueDate,
      this.completedAt,
      this.createdAt,
      this.updatedAt,
      this.subject,
      this.exam,
      this.title,
      this.repeatOption,
      this.endDate});

  DateTime getTaskDueDateTime() {
    return DateTime.tryParse(dueDate ?? "") ?? DateTime.now();
  }

   String getTaskDueFormattedDate() {
    DateTime? createdAtDate = DateTime.tryParse(dueDate ?? "");

    if (createdAtDate != null) {
      String formattedDate =
          DateFormat('EEE, dd MMM').format(createdAtDate);
      return formattedDate;
    } else {
      return "";
    }
  }

  Task.fromJson(Map<String, dynamic> json) {
    List<String> dayStrings = [];

    if (json['days'] != null) {
      List<dynamic> rawDays = json['days'];
      dayStrings = rawDays.map(
        (item) {
          return item as String;
        },
      ).toList();
    }

    id = json['id'];
    userId = json['userId'];
    subjectId = json['subjectId'];
    examId = json['examId'];
    classId = json['classId'];
    details = json['details'];
    type = json['type'];
    progress = json['progress'];
    category = json['category'];
    occurs = json['occurs'];
    days = dayStrings;
    dueDate = json['dueDate'];
    completedAt = json['completedAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    title = json['title'];
    endDate = json['endDate'];
    repeatOption = json['repeatOption'];
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    exam = json['exam'] != null ? Exam.fromJson(json['exam']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['subjectId'] = subjectId;
    data['examId'] = examId;
    data['classId'] = classId;
    data['details'] = details;
    data['type'] = type;
    data['progress'] = progress;
    data['category'] = category;
    data['occurs'] = occurs;
    data['days'] = days;
    data['dueDate'] = dueDate;
    data['completedAt'] = completedAt;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['title'] = title;
    data['repeatOption'] = repeatOption;
    data['endDate'] = endDate;
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    if (exam != null) {
      data['exam'] = exam!.toJson();
    }
    return data;
  }
}
