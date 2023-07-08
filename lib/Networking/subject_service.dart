import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';
import '../Models/API/subject.dart';

class SubjectService {
  static SubjectService? _instance;

  factory SubjectService() => _instance ??= SubjectService._();

  SubjectService._();

  Future<Response> getSubjects() async {
    var response = await Api().dio.get("/api/subject");

    return response;
  }

  Future<Response> createSubject(Subject subjectItem) async {
    String fileName = subjectItem.newImageUrl!.split('/').last;

    FormData formData = FormData.fromMap({
      "subject": subjectItem.subjectName,
      "color": subjectItem.colorHex,
      "image": await MultipartFile.fromFile(subjectItem.newImageUrl!,
          filename: fileName),
    });

    var response = await Api().dio.post('/api/subject', data: formData);

    return response;
  }

  Future<Response> updateSubject(Subject subjectItem) async {
    if (subjectItem.newImageUrl == null) {
      FormData formData = FormData.fromMap({
        "subject": subjectItem.subjectName,
        "color": subjectItem.colorHex,
      });

      var response =
          await Api().dio.put('/api/subject/${subjectItem.id}', data: formData);

      return response;
    } 
    else {
      String fileName = subjectItem.newImageUrl!.split('/').last;

      FormData formData = FormData.fromMap({
        "subject": subjectItem.subjectName,
        "color": subjectItem.colorHex,
        "image": await MultipartFile.fromFile(subjectItem.newImageUrl!,
            filename: fileName),
      });

      var response =
          await Api().dio.put('/api/subject/${subjectItem.id}', data: formData);

      return response;
    }
  }
}


//  if (holidayItem.newImagePath == null) {
      
//       FormData formData = FormData.fromMap({
//         "title": holidayItem.title,
//         "startDate": holidayItem.startDate,
//         "endDate": holidayItem.endDate,
//       });

//       var response = await Api().dio.put('/api/holiday/${holidayItem.id}', data: formData);

//       return response;
//     } else {
//       String fileName = holidayItem.newImagePath!.split('/').last;

//       FormData formData = FormData.fromMap({
//         "title": holidayItem.title,
//         "startDate": holidayItem.startDate,
//         "endDate": holidayItem.endDate,
//         "image": await MultipartFile.fromFile(holidayItem.newImagePath!,
//             filename: fileName),
//       });

//       var response = await Api().dio.put('/api/holiday/${holidayItem.id}', data: formData);

//       return response;
//     }