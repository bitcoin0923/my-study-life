// import 'dart:convert';

// import './network_client.dart';
// import 'package:http/http.dart' as http;
// import '../Models/API/result.dart';
// import '../Models/API/network_response.dart';
// import '../Models/API/access_token.dart';
// import 'package:jwt_decoder/jwt_decoder.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';


// class AuthAPI extends BaseAPI {
//   static String grantType = "password";
//   static String clientSecret = "Ri4jK9ujwaHkjrStwOEXQ0P3JTWlUNovQnZ4ffZJ";
//   static int clientId = 2;

//   Future<http.Response> signUp(String name, String email, String phone,
//       String password, String passwordConfirmation) async {
//     var body = jsonEncode({'email': email, 'password': password});
//     final url = Uri.parse(super.authPath);

//     http.Response response =
//         await http.post(url, headers: super.headers, body: body);
//     return response;
//   }

//   // Future<Result> login(String email, String password) async {
//   //   var body = jsonEncode({
//   //     'username': email,
//   //     'password': password,
//   //     'client_id': clientId,
//   //     'client_secret': clientSecret,
//   //     'grant_type': grantType
//   //   });

//   //   final url = Uri.parse("${super.authPath}/login");

//   //   try {
//   //     final response = await http.post(url, headers: super.headers, body: body);
//   //     if (response.statusCode == 200) {
//   //       var token = AccessToken.fromJson(response.body.);
//   //       // Save Token

//   //       var box = await Hive.openBox('tokenBox');
//   //       box.clear();
//   //       box.add(token);

//   //       return Result<AccessToken>.success(token);
//   //     } else {
//   //       return Result<NetworkResponse>.error(
//   //           NetworkResponse.fromRawJson(response.body));
//   //     }
//   //   } catch (error) {
//   //     return Result.error("Something went wrong!");
//   //   }
//   // }

//   // Future<Result> refreshToken() async {
//   //   var box = await Hive.openBox('tokenBox');
//   //   var token = box.getAt(0) as AccessToken;

//   //   var body = jsonEncode({
//   //     'refresh_token': token.refreshToken,
//   //   });

//   //   final url = Uri.parse("${super.authPath}/refresh_token");

//   //   try {
//   //     final response = await http.post(url, headers: super.headers, body: body);
//   //     if (response.statusCode == 200) {
//   //       var token = AccessToken.fromReqBody(response.body);
//   //       // Save Token
//   //       box.clear();
//   //       box.add(token);

//   //       return Result<AccessToken>.success(token);
//   //     } else {
//   //       return Result<NetworkResponse>.error(
//   //           NetworkResponse.fromRawJson(response.body));
//   //     }
//   //   } catch (error) {
//   //     return Result.error("Something went wrong!");
//   //   }
//   // }
// }
