import 'package:dio/dio.dart';
import './api_service.dart';
import '../Models/API/task.dart';
import 'dart:convert';

class TaskService {
  static TaskService? _instance;

  factory TaskService() => _instance ??= TaskService._();

  TaskService._();

  Future<Response> getTasks(int? subjectID, String? filter) async {
    Map<String, dynamic> queryParameters = {};

    if (subjectID != null) {
      final subjectFilter = <String, int>{"subject": subjectID};

      queryParameters.addEntries(subjectFilter.entries);
    }

    if (filter != null) {
      final subjectFilter = <String, String>{"filter": filter};

      queryParameters.addEntries(subjectFilter.entries);
    }

    var response =
        await Api().dio.get("/api/task", queryParameters: queryParameters);

    return response;
  }

  Future<Response> createTask(Task taskItem) async {
    String body;

    String? days = null;
    days = taskItem.days?.join(",");

    body = jsonEncode({
      'subjectId': taskItem.subject?.id ?? 0,
      'details': taskItem.details,
      'type': taskItem.type,
      'category': taskItem.category,
      'occurs': taskItem.occurs,
      'dueDate': taskItem.dueDate,
      'days': days,
      'examId': taskItem.examId,
      'progress': taskItem.progress,
      'completedAt': taskItem.completedAt,
    }..removeWhere((dynamic key, dynamic value) => value == null));

    var response = await Api().dio.post('/api/task', data: body);

    return response;
  }

  Future<Response> updateTask(Task taskItem) async {
    String body;

    String? days = null;
    days = taskItem.days?.join(",");

    body = jsonEncode({
      'subjectId': taskItem.subject?.id ?? 0,
      'details': taskItem.details,
      'type': taskItem.type,
      'category': taskItem.category,
      'occurs': taskItem.occurs,
      'dueDate': taskItem.dueDate,
      'days': days,
      'examId': taskItem.examId,
      'progress': taskItem.progress,
      'completedAt': taskItem.completedAt,
    }..removeWhere((dynamic key, dynamic value) => value == null));

    var response = await Api().dio.put('/api/task/${taskItem.id}', data: body);

    return response;
  }
}
