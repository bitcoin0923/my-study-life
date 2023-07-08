import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';

class CalendarEventService {
  static CalendarEventService? _instance;

  factory CalendarEventService() => _instance ??= CalendarEventService._();

  CalendarEventService._();

  Future<Response> getEvents(String startDate, String endDate) async {
    final params = <String, dynamic>{
      'startDate': startDate,
      'endDate': endDate,
    };

    var response =
        await Api().dio.get("/api/user/calendar", queryParameters: params);

    return response;
  }
}
