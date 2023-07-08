
// import 'dart:async';
// import 'package:http/http.dart';

// import './network_client.dart';
// import '../Models/API/network_response.dart';
// import '../Models/API/Util/request_type.dart';
// import '../Models/API/result.dart';

// class NetworkController {
//   //Creating Singleton
//   NetworkController._privateConstructor();
//   static final NetworkController _apiResponse = NetworkController._privateConstructor();
//   factory NetworkController() => _apiResponse;

//   NetworkClient client = NetworkClient(Client());


//   Future<Result> login(String email, String password) async {
//     try {
//       final response = await client.request(requestType: RequestType.POST, path: "api/login", parameter: {"email": email, "password": password});
//       if (response.statusCode == 200) {
//         print(response.body);
//         return Result<NetworkResponse>.success(
//             NetworkResponse.fromRawJson(response.body));
//       } else {
//           print(response.body);

//         return Result.error("Please check your email and password.");
//       }
//     } catch (error) {
      
//       return Result.error("Something went wrong!");
//     }
//   }
// }