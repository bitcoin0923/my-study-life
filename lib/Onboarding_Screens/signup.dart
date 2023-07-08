import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:beamer/beamer.dart';

import '../app.dart';
import '../Widgets/regular_teztField.dart';
import '../Utilities/constants.dart';
import '../Widgets/rounded_elevated_button.dart';
import '../Controllers/auth_notifier.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Extensions/extensions.dart';
import '../Networking/user_service.dart';
import 'package:dio/dio.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  @override
  void dispose() {
    // FocusScope.of(context).unfocus();
    super.dispose();
  }

  void _signUp(WidgetRef ref) async {
    String finalEmail = emailController.text;
    String finalPassword = passwordController.text;
    String finalConfirmPassword = confirmController.text;

    if (finalEmail.isEmpty ||
        finalPassword.isEmpty ||
        finalConfirmPassword.isEmpty) {
      CustomSnackBar.show(
          context, CustomSnackBarType.error, "Please fill in all fields.", false);
      return;
    }

    if (!finalEmail.isValidEmail) {
      CustomSnackBar.show(context, CustomSnackBarType.error,
          "Please enter valid email address.", false);
      return;
    }

    if (finalPassword != finalConfirmPassword) {
      CustomSnackBar.show(context, CustomSnackBarType.error,
          "Password and Confirm passwrod fields don't match.", false);
      return;
    }

    LoadingDialog.show(context);

    try {
      var response = await UserService().signUp(finalEmail, finalPassword);

      if (!context.mounted) return;

      LoadingDialog.hide(context);
      CustomSnackBar.show(
          context, CustomSnackBarType.success, response.data['message'], false);

      context.beamBack();
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(
            context, CustomSnackBarType.error, error.response?.data['message'], false);
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
                          margin: EdgeInsets.only(top: (height + 103)),
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
                                  'Sign up with Email',
                                  style: Constants.lightThemeTitleTextStyle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    top: 132, left: 39, right: 38),
                                child: Column(
                                  children: [
                                    RegularTextField(
                                      "Your email",
                                      (value) {
                                       // FocusScope.of(context).nextFocus();
                                      },
                                      TextInputType.emailAddress,
                                      emailController,
                                      false,
                                      autofocus: true,
                                    ),
                                    RegularTextField(
                                      "New Password",
                                      (value) {
                                      //  FocusScope.of(context).nextFocus();
                                      },
                                      TextInputType.visiblePassword,
                                      passwordController,
                                      false,
                                      autofocus: false,
                                      obscureText: true,
                                    ),
                                    RegularTextField(
                                      "Confirm Password",
                                      (value) {
                                       // FocusScope.of(context).unfocus();
                                      },
                                      TextInputType.visiblePassword,
                                      confirmController,
                                      false,
                                      autofocus: false,
                                      obscureText: true,
                                    ),
                                    RoundedElevatedButton(
                                        () => _signUp(ref),
                                        "Sign up",
                                        Constants.lightThemePrimaryColor,
                                        Colors.black,
                                        45)
                                  ],
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
                                  'Sign up with Email',
                                  style: Constants.darkThemeTitleTextStyle,
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                width: double.infinity,
                                margin: const EdgeInsets.only(
                                    top: 132, left: 39, right: 38),
                                child: Column(
                                  children: [
                                    RegularTextField(
                                      "Your email",
                                      (value) {
                                       // FocusScope.of(context).nextFocus();
                                      },
                                      TextInputType.emailAddress,
                                      emailController,
                                      true,
                                      autofocus: true,
                                    ),
                                    RegularTextField(
                                      "New Password",
                                      (value) {
                                       // FocusScope.of(context).nextFocus();
                                      },
                                      TextInputType.visiblePassword,
                                      passwordController,
                                      true,
                                      autofocus: false,
                                      obscureText: true,
                                    ),
                                    RegularTextField(
                                      "Confirm Password",
                                      (value) {
                                      //  FocusScope.of(context).unfocus();
                                      },
                                      TextInputType.visiblePassword,
                                      confirmController,
                                      true,
                                      autofocus: false,
                                      obscureText: true,
                                    ),
                                    RoundedElevatedButton(
                                        () => _signUp(ref),
                                        "Sign up",
                                        Constants.darkThemePrimaryColor,
                                        Colors.black,
                                        45)
                                  ],
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
