import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Widgets/regular_teztField.dart';
import '../app.dart';
import '../Widgets/rounded_elevated_button.dart';

import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import '../Extensions/extensions.dart';
import '../Networking/user_service.dart';
import 'dart:convert';

class ChangePasswordScreen extends StatefulWidget {
  ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final passwordController = TextEditingController();

  final newpasswordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  void _savePassword() async {
    var oldPassword = passwordController.text;
    var newPassword = newpasswordController.text;
    var confirmedPassword = confirmPasswordController.text;

    if (oldPassword.isEmpty) {
      CustomSnackBar.show(context, CustomSnackBarType.error,
          "Please add your current password.", true);
      return;
    }

    if (newPassword.isEmpty || confirmedPassword.isEmpty) {
      CustomSnackBar.show(context, CustomSnackBarType.error,
          "Please fill in both New and Confirm password fields.", true);
      return;
    }

    if (newPassword != confirmedPassword) {
      CustomSnackBar.show(context, CustomSnackBarType.error,
          "New Password and Confirm password fields don't match.", true);
      return;
    }

    var body =
        jsonEncode({'oldPassword': oldPassword, 'newPassword': newPassword});

    LoadingDialog.show(context);

    try {
      var response = await UserService().updateUserPassword(body);

      if (!context.mounted) return;

      LoadingDialog.hide(context);
      CustomSnackBar.show(
          context, CustomSnackBarType.success, response.data['message'], true);
      Navigator.pop(context);
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], true);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", true);
      }
    }
  }

  void _cancel(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(), 
        child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            foregroundColor:
                theme == ThemeMode.light ? Colors.black : Colors.white,
            shadowColor: Colors.transparent,
            elevation: 0.0,
            title: Text(
              'Change Password',
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color:
                      theme == ThemeMode.light ? Colors.black : Colors.white),
            ),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 138, left: 39, right: 38),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Existing Password',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeSubtitleTextStyle
                      : Constants.darkThemeSubtitleTextStyle,
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 6,
                ),
                RegularTextField(
                  "Enter Existing Password",
                  (value) {
                    // FocusScope.of(context).unfocus();
                  },
                  TextInputType.visiblePassword,
                  passwordController,
                  theme == ThemeMode.dark,
                  autofocus: false,
                ),
                Container(
                  height: 6,
                ),
                Text(
                  'New Password',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeSubtitleTextStyle
                      : Constants.darkThemeSubtitleTextStyle,
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 6,
                ),
                RegularTextField(
                  "Enter New Password",
                  (value) {
                    // FocusScope.of(context).unfocus();
                  },
                  TextInputType.visiblePassword,
                  newpasswordController,
                  theme == ThemeMode.dark,
                  autofocus: false,
                ),
                Container(
                  height: 6,
                ),
                Text(
                  'Confirm New Password',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeSubtitleTextStyle
                      : Constants.darkThemeSubtitleTextStyle,
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 6,
                ),
                RegularTextField(
                  "Confirm New Password",
                  (value) {
                    // FocusScope.of(context).unfocus();
                  },
                  TextInputType.visiblePassword,
                  confirmPasswordController,
                  theme == ThemeMode.dark,
                  autofocus: false,
                ),
                Container(
                  height: 20,
                ),
                Container(
                  height: 68,
                ),
                Container(
                  alignment: Alignment.topCenter,
                  width: double.infinity,
                  // margin: const EdgeInsets.only(top: 260),
                  padding: const EdgeInsets.only(left: 73, right: 72),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RoundedElevatedButton(_savePassword, "Change Password",
                          Constants.lightThemePrimaryColor, Colors.black, 45),
                      RoundedElevatedButton(() => _cancel(context), "Cancel",
                          Constants.blueButtonBackgroundColor, Colors.white, 45)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
