import './subject.dart';
import 'package:intl/intl.dart';

class Exam {
  int? id;
  int? userId;
  String? subjectId;
  bool? resit;
  String? type;
  String? module;
  String? mode;
  String? onlineUrl;
  String? room;
  String? seat;
  String? startDate;
  String? startTime;
  int? duration;
  String? createdAt;
  String? updatedAt;
  Subject? subject;
  String? building;
  String? teacher;
  String? occurs;

  Exam(
      {this.id,
      this.userId,
      this.subjectId,
      this.resit,
      this.type,
      this.module,
      this.mode,
      this.onlineUrl,
      this.room,
      this.seat,
      this.startDate,
      this.startTime,
      this.duration,
      this.createdAt,
      this.updatedAt,
      this.subject,
      this.building,
      this.teacher,
      this.occurs});

  // Calculated

  String getExamStartFormattedDate() {
    DateTime? createdAtDate = DateTime.tryParse(startDate ?? "");

    if (createdAtDate != null) {
      String formattedDate =
          DateFormat('EEE, dd MMM').format(createdAtDate);
      return formattedDate;
    } else {
      return "";
    }
  }

   DateTime getExamStartdateDateTime() {
    return DateTime.tryParse(startDate ?? "") ?? DateTime.now();
  }

  Exam.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    subjectId = json['subjectId'];
    resit = json['resit'];
    type = json['type'];
    module = json['module'];
    mode = json['mode'];
    onlineUrl = json['onlineUrl'];
    room = json['room'];
    seat = json['seat'];
    startDate = json['startDate'];
    startTime = json['startTime'];
    duration = json['duration'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    building = json['building'];
    teacher = json['teacher'];
    occurs = json['occurs'];
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['userId'] = userId;
    data['subjectId'] = subjectId;
    data['resit'] = resit;
    data['type'] = type;
    data['module'] = module;
    data['mode'] = mode;
    data['onlineUrl'] = onlineUrl;
    data['room'] = room;
    data['seat'] = seat;
    data['building'] = building;
    data['startDate'] = startDate;
    data['startTime'] = startTime;
    data['duration'] = duration;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['teacher'] = teacher;
    data['occurs'] = occurs;
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    return data;
  }
}
