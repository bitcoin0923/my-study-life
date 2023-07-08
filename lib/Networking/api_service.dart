import 'package:dio/dio.dart';
import '../Models/API/access_token.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';
import './user_service.dart';

class Api {
  final dio = createDio();
  final tokenDio = Dio(BaseOptions(baseUrl: "https://admin.mystudylife.borne.io"));

  Api._internal();

  static final _singleton = Api._internal();

  factory Api() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: "https://admin.mystudylife.borne.io",
      receiveTimeout: 30000, // 15 seconds
      connectTimeout: 30000,
      sendTimeout: 30000,
    ));

   

    dio.interceptors.addAll({
      AppInterceptors(dio),
    });
    
    return dio;
  }
}

class AppInterceptors extends Interceptor {
  final Dio dio;
  final _storage = const FlutterSecureStorage();

  AppInterceptors(this.dio);

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //var box = await Hive.openBox('tokenBox');
    AccessToken accessToken;
    var tokenString = await _storage.read(key: "access_token");

    // Check for existing token
    if (tokenString != null && tokenString.isNotEmpty) {
      // Decode token from storage

       var tokenData = JwtDecoder.decode(tokenString);

     // Map<String, dynamic> userMap = jsonDecode(tokenString);

      accessToken = AccessToken.fromJson(tokenData);

      bool hasExpired = JwtDecoder.isExpired(tokenString);

      if (hasExpired) {
        dio.interceptors.requestLock.lock();

        await UserService().refreshToken().then((response) async {

          var tokenString = response.data;
          accessToken = AccessToken.fromJson(response.data);
          // Save New Token
          await _storage.write(
              key: "access_token", value: tokenString);
        }).catchError((error, stackTrace) {
          handler.reject(error, true);
        }).whenComplete(() => dio.interceptors.requestLock.unlock());
        options.headers['Authorization'] = 'Bearer ${tokenString}';
      } else {
        options.headers['Authorization'] = 'Bearer ${tokenString}';
      }
    }

   // options.headers['Content-Type'] = "application/json; charset=UTF-8;";

    print(
        "Performing request path: ${options.uri} , method: ${options.method}, body: ${options.data}, headers: ${options.headers}");

    return handler.next(options);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    // switch (err.type) {
    //   case DioErrorType.connectTimeout:
    //   case DioErrorType.sendTimeout:
    //   case DioErrorType.receiveTimeout:
    //     throw DeadlineExceededException(err.requestOptions);
    //   case DioErrorType.response:
    //     switch (err.response?.statusCode) {
    //       case 400:
    //         throw BadRequestException(err.requestOptions);
    //       case 401:
    //         throw UnauthorizedException(err.requestOptions);
    //       case 404:
    //         throw NotFoundException(err.requestOptions);
    //       case 409:
    //         throw ConflictException(err.requestOptions);
    //       case 422:
    //         throw EmailTakenException(err.requestOptions);
    //       case 500:
    //         throw InternalServerErrorException(err.requestOptions);
    //     }
    //     break;
    //   case DioErrorType.cancel:
    //     break;
    //   case DioErrorType.other:
    //     throw NoInternetConnectionException(err.requestOptions);
    // }

    return handler.next(err);
  }
}

class BadRequestException extends DioError {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioError {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Unknown error occurred, please try again later.';
  }
}

class ConflictException extends DioError {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioError {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class EmailTakenException extends DioError {
  EmailTakenException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The email has already been taken.';
  }
}

class NotFoundException extends DioError {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';  
  }
}

class NoInternetConnectionException extends DioError {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}

class DeadlineExceededException extends DioError {
  DeadlineExceededException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The connection has timed out, please try again.';
  }
}
