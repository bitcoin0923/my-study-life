import '../Models/user.model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Networking/user_service.dart';
import 'package:dio/dio.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Widgets/custom_snack_bar.dart';
import './navigation_service.dart';
import 'package:flutter/material.dart';
import '../app.dart';
import 'package:beamer/beamer.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AppRepository {
  final _storage = const FlutterSecureStorage();

  Future<UserModel> loginUser(String email, String password) async {
    try {
      var response = await UserService().login(email, password);

      var user = UserModel.fromJson(response.data['user']);

      return user;
    } catch (error) {
      final context = scaffoldMessengerKey.currentContext!;
      if (error is DioError) {
        print(error.response?.data['message']);

        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], false);
        return UserModel.empty;
      } else {
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", false);
        return UserModel.empty;
      }
    }

    // if (username == 'beamer' && password == 'supersecret') {
    //   /// this is where you would do your API call and check if it was successful
    //   /// also store the `UserModel` in cache
    //   return UserModel(
    //       token: "0cc136ea-2862-49c5-832a-2fcacc498637", username: "Beamer");
    // } else {
    //   return UserModel.empty;
    // }
  }

  Future<UserModel> loginGoogleUser(
      String email, String userId, String firstName, String lastName) async {
    try {
      var response = await UserService()
          .loginGoogleUser(email, userId, firstName, lastName);

      var user = UserModel.fromJson(response.data['user']);

      return user;
    } catch (error) {
      final context = scaffoldMessengerKey.currentContext!;
      if (error is DioError) {
        print(error.response?.data['message']);

        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], false);
        return UserModel.empty;
      } else {
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", false);
        return UserModel.empty;
      }
    }

    // if (username == 'beamer' && password == 'supersecret') {
    //   /// this is where you would do your API call and check if it was successful
    //   /// also store the `UserModel` in cache
    //   return UserModel(
    //       token: "0cc136ea-2862-49c5-832a-2fcacc498637", username: "Beamer");
    // } else {
    //   return UserModel.empty;
    // }
  }

  Future<UserModel> loginFacebookUser(
      String email, String userId, String firstName, String lastName) async {
    try {
      var response = await UserService()
          .loginFacebookUser(email, userId, firstName, lastName);

      var user = UserModel.fromJson(response.data['user']);

      return user;
    } catch (error) {
      final context = scaffoldMessengerKey.currentContext!;
      if (error is DioError) {
        print(error.response?.data['message']);

        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], false);
        return UserModel.empty;
      } else {
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", false);
        return UserModel.empty;
      }
    }

    // if (username == 'beamer' && password == 'supersecret') {
    //   /// this is where you would do your API call and check if it was successful
    //   /// also store the `UserModel` in cache
    //   return UserModel(
    //       token: "0cc136ea-2862-49c5-832a-2fcacc498637", username: "Beamer");
    // } else {
    //   return UserModel.empty;
    // }
  }

  Future<void> logoutUser() async {
    /// on logout, delete the cache of userdata
    ///
    _storage.deleteAll();
  }
}

final appRepositoryProvider = Provider<AppRepository>((ref) => AppRepository());
