import 'package:dio/dio.dart';
import './api_service.dart';
import '../Models/API/holiday.dart';
import 'dart:convert';

class HolidayService {
  static HolidayService? _instance;

  factory HolidayService() => _instance ??= HolidayService._();

  HolidayService._();

  Future<Response> getHolidays(String? filter) async {
    Map<String, dynamic> queryParameters = {};

    if (filter != null) {
      final subjectFilter = <String, String>{"filter": filter};

      queryParameters.addEntries(subjectFilter.entries);
    }

    var response =
        await Api().dio.get("/api/holiday", queryParameters: queryParameters);

    return response;
  }

  Future<Response> createHoliday(Holiday holidayItem) async {
    if (holidayItem.newImagePath == null) {
      
      FormData formData = FormData.fromMap({
        "title": holidayItem.title,
        "startDate": holidayItem.startDate,
        "endDate": holidayItem.endDate,
      });

      var response = await Api().dio.post('/api/holiday', data: formData);

      return response;
    } else {
      String fileName = holidayItem.newImagePath!.split('/').last;

      FormData formData = FormData.fromMap({
        "title": holidayItem.title,
        "startDate": holidayItem.startDate,
        "endDate": holidayItem.endDate,
        "image": await MultipartFile.fromFile(holidayItem.newImagePath!,
            filename: fileName),
      });

      var response = await Api().dio.post('/api/holiday', data: formData);

      return response;
    }
  }

  Future<Response> updateHoliday(Holiday holidayItem) async {
    if (holidayItem.newImagePath == null) {
      
      FormData formData = FormData.fromMap({
        "title": holidayItem.title,
        "startDate": holidayItem.startDate,
        "endDate": holidayItem.endDate,
      });

      var response = await Api().dio.put('/api/holiday/${holidayItem.id}', data: formData);

      return response;
    } else {
      String fileName = holidayItem.newImagePath!.split('/').last;

      FormData formData = FormData.fromMap({
        "title": holidayItem.title,
        "startDate": holidayItem.startDate,
        "endDate": holidayItem.endDate,
        "image": await MultipartFile.fromFile(holidayItem.newImagePath!,
            filename: fileName),
      });

      var response = await Api().dio.put('/api/holiday/${holidayItem.id}', data: formData);

      return response;
    }
  }
}
