import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';
import '../Models/API/classmodel.dart';

class ClassService {
  static ClassService? _instance;

  factory ClassService() => _instance ??= ClassService._();

  ClassService._();

  Future<Response> getClasses(int? subjectID) async {
    var response = await Api().dio.get("/api/class");

    return response;
  }

  Future<Response> createClass(ClassModel classItem) async {
    String body;

    String? days = null;
    days = classItem.days?.join(",");

    body = jsonEncode({
      'subjectId': classItem.subject?.id ?? 0,
      'module': classItem.module,
      'mode' : classItem.mode,
      'room': classItem.room,
      'building': classItem.building,
      'teacher': classItem.teacher,
      'occurs': classItem.occurs,
      'days': days,
      'startTime': classItem.startTime,
      'endTime': classItem.endTime,
      'startDate': classItem.startDate,
      'onlineUrl': classItem.onlineUrl,
      'teachersEmail': classItem.teachersEmail

    }..removeWhere((dynamic key, dynamic value) => value == null));

    var response = await Api().dio.post(
        '/api/class',
        data: body);

    return response;
  }

   Future<Response> updateClass(ClassModel classItem) async {
    String body;

    String? days = null;
    days = classItem.days?.join(",");

    body = jsonEncode({
      'subjectId': classItem.subject?.id ?? 0,
      'module': classItem.module,
      'mode' : classItem.mode,
      'room': classItem.room,
      'building': classItem.building,
      'teacher': classItem.teacher,
      'occurs': classItem.occurs,
      'days': days,
      'startTime': classItem.startTime,
      'endTime': classItem.endTime,
      'startDate': classItem.startDate,
      'onlineUrl': classItem.onlineUrl,
      'teachersEmail': classItem.teachersEmail

    }..removeWhere((dynamic key, dynamic value) => value == null));

    var response = await Api().dio.put(
        '/api/class/${classItem.id}',
        data: body);

    return response;
  }
}
