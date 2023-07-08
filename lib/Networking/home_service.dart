import 'package:dio/dio.dart';
import './api_service.dart';

class HomeService {
  static HomeService? _instance;

  factory HomeService() => _instance ??= HomeService._();

  HomeService._();

  Future<Response> getHomeData() async {

    var response = await Api().dio.get("/api/user/home");

    return response;
  }
}