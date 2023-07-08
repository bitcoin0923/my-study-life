import '../Models/API/access_token.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'package:dio/dio.dart';
import './api_service.dart';
import 'dart:convert';
import '../Models/user.model.dart';

class UserService {
  static UserService? _instance;
  static String grantType = "password";
  static String clientSecret = "Ri4jK9ujwaHkjrStwOEXQ0P3JTWlUNovQnZ4ffZJ";
  static int clientId = 2;
  final _storage = const FlutterSecureStorage();

  factory UserService() => _instance ??= UserService._();

  UserService._();

  Future<Response> signUp(String email, String password) async {
    var body = jsonEncode({
      "first_name": "Mystudylife",
      "last_name": "User",
      'email': email,
      'password': password,
    });

    var response = await Api().tokenDio.post('/api/auth/sign-up', data: body);

    return response;
  }

  Future<Response> login(String email, String password) async {
    var body = jsonEncode({
      'email': email,
      'password': password,
      // 'client_id': clientId,
      // 'client_secret': clientSecret,
      // 'grant_type': grantType
    });

    var response = await Api().tokenDio.post('/api/auth/login', data: body);
    if (response.statusCode == 200) {
      // var tokenData = JwtDecoder.decode(response.data['token']);
      var tokenString = response.data['token'];
      // print("TOKEN DATA $tokenData");

      // var token = AccessToken.fromJson(tokenData);
      var user = UserModel.fromJson(response.data['user']);

      await _storage.write(key: "access_token", value: tokenString);
      await _storage.write(key: "activeUser", value: jsonEncode(user.toJson()));
    }

    return response;
  }

  Future<Response> loginGoogleUser(
      String email, String userId, String firstName, String lastName) async {
    var body = jsonEncode({
      'email': email,
      'providerUserId': userId,
      "firstName": firstName,
      "lastName": lastName,
    });

    var response = await Api().tokenDio.post('/api/auth/google', data: body);
    if (response.statusCode == 200) {
      // var tokenData = JwtDecoder.decode(response.data['token']);
      var tokenString = response.data['token'];
      // print("TOKEN DATA $tokenData");

      // var token = AccessToken.fromJson(tokenData);
      var user = UserModel.fromJson(response.data['user']);

      await _storage.write(key: "access_token", value: tokenString);
      await _storage.write(key: "activeUser", value: jsonEncode(user.toJson()));
    }

    return response;
  }

  Future<Response> loginFacebookUser(
      String email, String userId, String firstName, String lastName) async {
    var body = jsonEncode({
      'email': email,
      'providerUserId': userId,
      "firstName": firstName,
      "lastName": lastName,
    });

    var response = await Api().tokenDio.post('/api/auth/facebook', data: body);
    if (response.statusCode == 200) {
      // var tokenData = JwtDecoder.decode(response.data['token']);
      var tokenString = response.data['token'];
      // print("TOKEN DATA $tokenData");

      // var token = AccessToken.fromJson(tokenData);
      var user = UserModel.fromJson(response.data['user']);

      await _storage.write(key: "access_token", value: tokenString);
      await _storage.write(key: "activeUser", value: jsonEncode(user.toJson()));
    }

    return response;
  }

  Future<Response> refreshToken() async {
    var tokenString = await _storage.read(key: "access_token");

    // Check for existing token
    if (tokenString != null && tokenString.isNotEmpty) {
      // Decode token from storage
      Map<String, dynamic> userMap = jsonDecode(tokenString);

      var accessToken = AccessToken.fromJson(userMap);

      var body = jsonEncode({
        'refreshToken': accessToken.refreshToken,
        // 'client_id': clientId,
        // 'client_secret': clientSecret,
      });
      var response =
          await Api().tokenDio.post('/api/auth/refresh-token', data: body);

      return response;
    } else {
      var response = await Api().tokenDio.post('/api/auth/refresh-token');

      return response;
    }
  }

  Future<Response> getUser() async {
    var response = await Api().dio.get('/api/user');

    if (response.statusCode == 200) {
      var user = UserModel.fromJson(response.data['user']);

      await _storage.write(
          key: "activeUser", value: jsonEncode(user.toJson()));
    }

    return response;
  }

  Future<Response> updateUser(String body) async {
    // final map = <String, dynamic>{};
    // map.putIfAbsent('Content-Type', () => "application/json");
    var response = await Api()
        .dio
        .put('/api/user', data: body);

    // if (response.statusCode == 201 || response.statusCode == 200) {
    //   var user = UserModel.fromJson(response.data['data']);

    //   await _storage.write(
    //       key: "activeUser", value: jsonEncode(user.toJson()));
    // }

    return response;
  }

  Future<Response> updateProfilePicture(String imagePath) async {
    String fileName = imagePath.split('/').last;

    FormData formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(imagePath, filename: fileName),
    });

    var response =
        await Api().dio.post('/api/user/profile-image', data: formData);

    return response;
  }

  Future<Response> updateUserPassword(String body) async {
    var response = await Api().dio.put('/api/user/password', data: body);

    return response;
  }

  Future<Response> createStripeOnboardingLink() async {
    var response =
        await Api().dio.post('/api/user/create-stripe-onboarding-link');

    return response;
  }

  Future<Response> getHelp(String message) async {
    var body = jsonEncode({'message': message});

    var response = await Api().dio.post('/api/user/get-help', data: body);

    return response;
  }

  Future<Response> deleteUser() async {
    var response = await Api().dio.get('/api/user/forgetMe');

    return response;
  }

  Future<Response> resetPassword(String email) async {
    var body = jsonEncode({'email': email});

    var response =
        await Api().dio.post('/api/auth/forgot-password', data: body);

    return response;
  }
}
