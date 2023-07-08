

// import 'dart:convert';
// import 'package:http/http.dart';
// import 'package:meta/meta.dart';

// import '../Models/API/Util/nothing.dart';
// import '../Models/API/Util/request_type.dart';
// import '../Models/API/Util/request_type_exception.dart';

// class NetworkClient {
//   //Base url
//   static const String _baseUrl = "http://178.62.28.137:8080/drivous/public/index.php/"; 
//   final Client _client;

//   NetworkClient(this._client);

//   Future<Response> request({required RequestType requestType, required String path, dynamic parameter = Nothing}) async {
//     final url = Uri.parse("$_baseUrl/$path");

//     switch (requestType) {
//       case RequestType.GET:
//         return _client.get(url);
//       case RequestType.POST:
//         return _client.post(url,
//             headers: {"Content-Type": "application/json"}, body: json.encode(parameter));
//       case RequestType.DELETE:
//         return _client.delete(url);
//       default:
//         return throw RequestTypeNotFoundException("The HTTP request mentioned is not found");
//     }
//   }
// }

// class BaseAPI{
//     static String base = "https://drinktank.borne.io"; 
//     static var api = base + "/api";
//     var customersPath = api + "/customers";
//     var authPath = api + "/auth"; 
//    // more routes
//    Map<String,String> headers = {                           
//        "Content-Type": "application/json; charset=UTF-8" };                                      
              
// }
