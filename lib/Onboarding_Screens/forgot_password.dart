import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import '../app.dart';
import '../Widgets/regular_teztField.dart';
import '../Utilities/constants.dart';
import '../Widgets/rounded_elevated_button.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Extensions/extensions.dart';
import '../Networking/user_service.dart';
import 'package:dio/dio.dart';

class ForgotPasswordScreen extends StatefulWidget {
  ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();

  void _goBack(BuildContext context) {
    context.beamBack();
  }

  void _send(WidgetRef ref) async {
    String finalEmail = emailController.text;
    //final context = scaffoldMessengerKey.currentContext!;

    if (finalEmail.isEmpty) {
      CustomSnackBar.show(
          context, CustomSnackBarType.error, "Please enter email address.", false);
      return;
    }

    if (!finalEmail.isValidEmail) {
      CustomSnackBar.show(context, CustomSnackBarType.error,
          "Please enter valid email address.", false);
      return;
    }

    LoadingDialog.show(context);

    try {
      var response = await UserService().resetPassword(finalEmail);

      if (!context.mounted) return;

      LoadingDialog.hide(context);
      CustomSnackBar.show(
          context, CustomSnackBarType.success, response.data['message'], false);

    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(
            context, CustomSnackBarType.error, error.response?.data['msg'], false);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(
            context, CustomSnackBarType.error, "Oops, something went wrong", false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      var height = MediaQuery.of(context).padding.top;

      return GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor:
                  theme == ThemeMode.light ? Colors.black : Colors.white,
              shadowColor: Colors.transparent,
              elevation: 0.0,
              title: const Text(
                '',
              ),
            ),
            body: Container(
              color: theme == ThemeMode.light
                  ? Colors.white
                  : Constants.darkThemeBackgroundColor,
              child: theme == ThemeMode.light
                  ? Stack(
                      // Light Theme
                      children: [
                        Image.asset("assets/images/LoginSignupBackground.png"),
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: EdgeInsets.only(top: (height + 133)),
                          height: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(45.0),
                                topLeft: Radius.circular(45.0)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 52),
                                height: 28,
                                child: Text(
                                  'Forgot Password?',
                                  style: Constants.lightThemeTitleTextStyle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.only(left: 35, right: 35),
                                margin: const EdgeInsets.only(top: 93),
                                height: 38,
                                child: Text(
                                  'Enter your registered email and we will send you a password reset link.',
                                  style: Constants.roboto15LightThemeTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    top: 179, left: 39, right: 38),
                                child: Column(
                                  children: [
                                    RegularTextField(
                                      "Your email",
                                      (value) {
                                       // FocusScope.of(context).unfocus();
                                      },
                                      TextInputType.emailAddress,
                                      emailController,
                                      false,
                                      autofocus: true,
                                    ),
                                    RoundedElevatedButton(
                                        () => _send(ref),
                                        "Send Password reset link",
                                        Constants.lightThemePrimaryColor,
                                        Colors.black,
                                        45),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 326),
                                child: TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent)),
                                  onPressed: () => _goBack(context),
                                  child: Text("Back To Login",
                                      style: Constants
                                          .lightThemeTextButtonTextStyle),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      // Dark Theme
                      children: [
                        Image.asset(
                            "assets/images/LoginSignupBackgroundDark.png"),
                        Container(
                          alignment: Alignment.topCenter,
                          width: double.infinity,
                          margin: const EdgeInsets.only(top: 133),
                          height: double.infinity,
                          decoration: BoxDecoration(
                            color: Constants.darkThemeSecondaryBackgroundColor,
                            borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(45.0),
                                topLeft: Radius.circular(45.0)),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                blurRadius: 15.0, // soften the shadow
                                spreadRadius: 5.0, //extend the shadow
                                offset: Offset(
                                  5.0, // Move to right 5  horizontally
                                  5.0, // Move to bottom 5 Vertically
                                ),
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 52),
                                height: 28,
                                child: Text(
                                  'Forgot Password?',
                                  style: Constants.darkThemeTitleTextStyle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 93),
                                padding:
                                    const EdgeInsets.only(left: 35, right: 35),
                                height: 38,
                                child: Text(
                                  'Enter your registered email and we will send you a password reset link.',
                                  style: Constants.roboto15DarkThemeTextStyle,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    top: 179, left: 39, right: 38),
                                child: Column(
                                  children: [
                                    RegularTextField(
                                      "Your email",
                                      (value) {
                                       // FocusScope.of(context).unfocus();
                                      },
                                      TextInputType.emailAddress,
                                      emailController,
                                      true,
                                      autofocus: true,
                                    ),
                                    RoundedElevatedButton(
                                        () => _send(ref),
                                        "Send Password reset link",
                                        Constants.darkThemePrimaryColor,
                                        Colors.black,
                                        45),
                                  ],
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(top: 326),
                                child: TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent)),
                                  onPressed: () => _goBack(context),
                                  child: Text("Back To Login",
                                      style: Constants
                                          .darkThemeTextButtonTextStyle),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            )),
      );
    });
  }
}
