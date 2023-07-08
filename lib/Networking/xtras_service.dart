import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';
import '../Models/API/xtra.dart';

class XtrasService {
  static XtrasService? _instance;

  factory XtrasService() => _instance ??= XtrasService._();

  XtrasService._();

  Future<Response> getXtras(String? filter) async {
    Map<String, dynamic> queryParameters = {};

    if (filter != null) {
      final subjectFilter = <String, String>{"filter": filter};

      queryParameters.addEntries(subjectFilter.entries);
    }

    var response =
        await Api().dio.get("/api/xtra", queryParameters: queryParameters);

    return response;
  }

  Future<Response> createXtra(Xtra xtraItem) async {
    String? days = null;
    days = xtraItem.days?.join(",");

    if (xtraItem.newImagePath == null) {
      FormData formData = FormData.fromMap({
        'name': xtraItem.name ?? "",
        'startDate': xtraItem.startDate,
        'endDate': xtraItem.endDate,
        'startTime': xtraItem.startTime,
        'occurs': xtraItem.occurs,
        'endTime': xtraItem.endTime,
        'days': days,
        'eventType': xtraItem.eventType,
      }..removeWhere((dynamic key, dynamic value) => value == null));

      var response = await Api().dio.post('/api/xtra', data: formData);

      return response;
    } else {
      String fileName = xtraItem.newImagePath!.split('/').last;

      FormData formData = FormData.fromMap({
        'name': xtraItem.name ?? "",
        'startDate': xtraItem.startDate,
        'endDate': xtraItem.endDate,
        'startTime': xtraItem.startTime,
        'occurs': xtraItem.occurs,
        'endTime': xtraItem.endTime,
        'days': days,
        'eventType': xtraItem.eventType,
        "image": await MultipartFile.fromFile(xtraItem.newImagePath!,
            filename: fileName),
      }..removeWhere((dynamic key, dynamic value) => value == null));
      var response = await Api().dio.post('/api/xtra', data: formData);
      return response;
    }
  }

  Future<Response> updateXtra(Xtra xtraItem) async {
    String? days = null;
    days = xtraItem.days?.join(",");

    if (xtraItem.newImagePath == null) {
      FormData formData = FormData.fromMap({
        'name': xtraItem.name ?? "",
        'startDate': xtraItem.startDate,
        'endDate': xtraItem.endDate,
        'startTime': xtraItem.startTime,
        'occurs': xtraItem.occurs,
        'endTime': xtraItem.endTime,
        'days': days,
        'eventType': xtraItem.eventType,
      }..removeWhere((dynamic key, dynamic value) => value == null));

      var response =
          await Api().dio.put('/api/xtra/${xtraItem.id}', data: formData);

      return response;
    } else {
      String fileName = xtraItem.newImagePath!.split('/').last;

      FormData formData = FormData.fromMap({
        'name': xtraItem.name ?? "",
        'startDate': xtraItem.startDate,
        'endDate': xtraItem.endDate,
        'startTime': xtraItem.startTime,
        'occurs': xtraItem.occurs,
        'endTime': xtraItem.endTime,
        'days': days,
        'eventType': xtraItem.eventType,
        "image": await MultipartFile.fromFile(xtraItem.newImagePath!,
            filename: fileName),
      }..removeWhere((dynamic key, dynamic value) => value == null));
      var response =
          await Api().dio.put('/api/xtra/${xtraItem.id}', data: formData);
      return response;
    }
  }
}
