import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Widgets/regular_teztField.dart';
import '../app.dart';
import '../Widgets/rounded_elevated_button.dart';
import '../Models/user.model.dart';
import '../../Widgets/loaderIndicator.dart';
import '../../Widgets/custom_snack_bar.dart';
import 'package:dio/dio.dart';
import '../Extensions/extensions.dart';
import '../Networking/user_service.dart';
import 'dart:convert';

class ChangeEmailScreen extends StatefulWidget {
  final UserModel? activeUser;
  ChangeEmailScreen(this.activeUser, {super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmEmailController = TextEditingController();

  void _saveEmail() async {
    if (widget.activeUser != null) {
      var currentEmail = emailController.text;
      // var currentPassword = passwordController.text;
      var newEmail = confirmEmailController.text;

      if (currentEmail.isEmpty) {
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Please add your current email.", true);
        return;
      }

      if (currentEmail != widget.activeUser?.email) {
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Current email not correct", true);
        return;
      }

      if (newEmail.isEmpty) {
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Please add your new email.", true);
        return;
      }

      // if (currentEmail != newEmail) {
      //   CustomSnackBar.show(
      //       context, CustomSnackBarType.error, "Emails don't match.", true);
      //   return;
      // }
      // if (currentEmail != newEmail) {
      //   CustomSnackBar.show(
      //       context, CustomSnackBarType.error, "Emails don't match.", true);
      //   return;
      // }

      if (!newEmail.isValidEmail) {
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Please enter valid email address.", true);
        return;
      }

      var body = jsonEncode({
        'email': newEmail,
      });

      LoadingDialog.show(context);

      try {
        var response = await UserService().updateUser(body);

        if (!context.mounted) return;

        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.success,
            response.data['message'], true);
        Navigator.pop(context);
      } catch (error) {
       // print("ADSDADSADAD ${error.toString()}");
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
    } else {
      CustomSnackBar.show(context, CustomSnackBarType.error,
          "Error. Can't get active user", true);
      return;
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
              'Change Email',
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
                  'Existing Email',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeSubtitleTextStyle
                      : Constants.darkThemeSubtitleTextStyle,
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 6,
                ),
                RegularTextField(
                  "Enter Existing Email",
                  (value) {
                    //FocusScope.of(context).unfocus();
                  },
                  TextInputType.emailAddress,
                  emailController,
                  theme == ThemeMode.dark,
                  autofocus: false,
                ),
                Container(
                  height: 6,
                ),
                // Text(
                //   'Password',
                //   style: theme == ThemeMode.light
                //       ? Constants.lightThemeSubtitleTextStyle
                //       : Constants.darkThemeSubtitleTextStyle,
                //   textAlign: TextAlign.left,
                // ),
                // Container(
                //   height: 6,
                // ),
                // RegularTextField(
                //   "Enter Password",
                //   (value) {
                //     // FocusScope.of(context).unfocus();
                //   },
                //   TextInputType.visiblePassword,
                //   passwordController,
                //   theme == ThemeMode.dark,
                //   autofocus: false,
                // ),
                // Container(
                //   height: 6,
                // ),
                Text(
                  'New Email',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeSubtitleTextStyle
                      : Constants.darkThemeSubtitleTextStyle,
                  textAlign: TextAlign.left,
                ),
                Container(
                  height: 6,
                ),
                RegularTextField(
                  "Enter New Email",
                  (value) {
                    // FocusScope.of(context).unfocus();
                  },
                  TextInputType.emailAddress,
                  confirmEmailController,
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
                      RoundedElevatedButton(_saveEmail, "Change Email",
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
