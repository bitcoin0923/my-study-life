import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import './subject.dart';
import 'package:intl/intl.dart';

enum EventType {
  classEvent,
  examEvent,
  taskDueEvent,
  breakEvent,
  prepTimeEvent,
  eventsEvent
}

class Event {
  String? title;
  String? eventTypeRaw;
  int? id;
  int? duration;
  String? module;
  String? mode;
  String? room;
  String? building;
  String? onlineUrl;
  String? teacher;
  String? teachersEmail;
  String? occurs;
  List<String>? days;
  bool? resit;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  String? createdAt;
  EventType? eventType;
  Subject? subject;
  String? seat;

  // Calculated

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

  TimeOfDay toTimeOfDay(String? time) {
    if (time != null && time.isNotEmpty) {
      List<String> timeSplit = time.split(":");
      int hour = int.parse(timeSplit.first);
      int minute = int.parse(timeSplit[1]);
      return TimeOfDay(hour: hour, minute: minute);
    } else {
      return TimeOfDay.now();
    }
  }

  EventType getEventType() {
    switch (eventTypeRaw) {
      case "class":
        return EventType.classEvent;
      case "exam":
        return EventType.eventsEvent;
      case "holiday":
        return EventType.breakEvent;
      case "task":
        return EventType.taskDueEvent;
      default:
        return EventType.classEvent;
    }
  }

  Event(
      {this.title,
      this.eventTypeRaw,
      this.eventType,
      this.id,
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
      this.createdAt,
      this.subject,
      this.duration,
      this.resit,
      this.seat});

  Event.fromJson(Map<String, dynamic> json) {
    List<String> dayStrings = [];

    if (json['days'] != null) {
      List<dynamic> rawDays = json['days'];
      dayStrings = rawDays.map(
        (item) {
          return item as String;
        },
      ).toList();
    }

    eventTypeRaw = json['eventType'];
    id = json['id'];
    module = json['module'];
    mode = json['mode'];
    room = json['room'];
    building = json['building'];
    onlineUrl = json['onlineUrl'];
    teacher = json['teacher'];
    teachersEmail = json['teachersEmail'];
    occurs = json['occurs'];
    days = dayStrings;
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    createdAt = json['createdAt'];
    duration = json['duration'];
    resit = json['resit'];
    seat = json['seat'];
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['eventType'] = this.eventTypeRaw;
    data['id'] = this.id;
    data['module'] = this.module;
    data['mode'] = this.mode;
    data['room'] = this.room;
    data['building'] = this.building;
    data['onlineUrl'] = this.onlineUrl;
    data['teacher'] = this.teacher;
    data['teachersEmail'] = this.teachersEmail;
    data['occurs'] = this.occurs;
    data['days'] = days;
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['createdAt'] = this.createdAt;
    data['duration'] = this.duration;
    data['resit'] = resit;
    data['seat'] = seat;
    return data;
  }
}
