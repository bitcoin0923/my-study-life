import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import '../Widgets/social_login_widget.dart';
import '../Widgets/rounded_elevated_button.dart';
import './login.dart';
import '../Controllers/auth_notifier.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Extensions/extensions.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'https://www.googleapis.com/auth/userinfo.profile'],
  );

  //final FacebookAuth _facebookAuth = F

  GoogleSignInAccount? _currentUser;
  bool _isAuthorized = false;
  String firstName = '';
  String lastName = '';
  String userId = '';
  String email = '';

  @override
  void initState() {
    super.initState();

    // _googleSignIn.onCurrentUserChanged
    //     .listen((GoogleSignInAccount? account) async {
    //   // In mobile, being authenticated means being authorized...
    //   bool isAuthorized = account != null;
    //   // However, in the web...
    //   // if (kIsWeb && account != null) {
    //   //   isAuthorized = await _googleSignIn.canAccessScopes(scopes);
    //   // }

    //   setState(() {
    //     _currentUser = account;
    //     _isAuthorized = isAuthorized;
    //   });

    //   // Now that we know that the user can access the required scopes, the app
    //   // can call the REST API.
    //   if (isAuthorized) {
    //     // unawaited(_handleGetContact(account!));
    //   }
    // });

    // // In the web, _googleSignIn.signInSilently() triggers the One Tap UX.
    // //
    // // It is recommended by Google Identity Services to render both the One Tap UX
    // // and the Google Sign In button together to "reduce friction and improve
    // // sign-in rates" ([docs](https://developers.google.com/identity/gsi/web/guides/display-button#html)).
    // _googleSignIn.signInSilently();
  }

  // This is the on-click handler for the Sign In button that is rendered by Flutter.
  //
  // On the web, the on-click handler of the Sign In button is owned by the JS
  // SDK, so this method can be considered mobile only.
  Future<void> _handleSignIn(WidgetRef ref) async {
    try {
      _currentUser = await _googleSignIn.signIn();
      var parts = _currentUser?.displayName?.split(' ');
      if (parts != null) {
        firstName = parts[0].trim();
        lastName = parts[1].trim();
      }
      email = _currentUser?.email ?? "";
      userId = _currentUser?.id ?? "";

      if (firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          userId.isNotEmpty) {
        loginGoogleUser(ref);
      }

    } catch (error) {
      print(error);
    }
  }

  // On the web, this must be called from an user interaction (button click).
  Future<void> _handleAuthorizeScopes() async {
    final bool isAuthorized =
        await _googleSignIn.requestScopes(_googleSignIn.scopes);
    setState(() {
      _isAuthorized = isAuthorized;
    });
    if (isAuthorized) {
      // unawaited(_handleGetContact(_currentUser!));
    }
  }

  Future<void> _handleSignOut() => _googleSignIn.disconnect();

  void _appleLogin() {}

  void _facebookLogin(WidgetRef ref) async {
    final LoginResult result = await FacebookAuth.instance.login();

    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      final userData = await FacebookAuth.instance.getUserData(
        fields: "name,email,picture.width(200),link",
      );

      var parts = userData['name'].split(' ');
      if (parts != null) {
        firstName = parts[0].trim();
        lastName = parts[1].trim();
      }
      email = userData['email'] ?? "";
      userId = userData['id'] ?? "";

      if (firstName.isNotEmpty &&
          lastName.isNotEmpty &&
          email.isNotEmpty &&
          userId.isNotEmpty) {
        loginFacebookUser(ref);
      }
    } else {
      print(result.status);
      print(result.message);
    }
  }

  void _googleLogin(WidgetRef ref) {
    _handleSignIn(ref);
  }

  void _officeLogin() {}

  void _login(BuildContext context, WidgetRef ref) {
    context.beamToNamed('/started/login');
  }

  void _signUp(BuildContext context) {
    context.beamToNamed('/started/signup');
  }

  void _openTermsAndConditions() {}

  void loginGoogleUser(WidgetRef ref) async {
    LoadingDialog.show(context);

    await ref
        .read(authProvider.notifier)
        .loginGoogleUser(email, userId, firstName, lastName);

    if (!context.mounted) return;

    LoadingDialog.hide(context);

    var loggedIn = ref.read(authProvider.notifier);

    if (loggedIn.state.status == AuthStatus.authenticated) {
      // context.beamBack();
      Beamer.of(context).update();
    }
  }

  void loginFacebookUser(WidgetRef ref) async {
    LoadingDialog.show(context);

    await ref
        .read(authProvider.notifier)
        .loginFacebookUser(email, userId, firstName, lastName);

    if (!context.mounted) return;

    LoadingDialog.hide(context);

    var loggedIn = ref.read(authProvider.notifier);

    if (loggedIn.state.status == AuthStatus.authenticated) {
      // context.beamBack();
      Beamer.of(context).update();
    }
  }

  // static final loginRouterDelegate = BeamerDelegate(
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      double screenWidth = MediaQuery.of(context).size.width;

      return Scaffold(
        resizeToAvoidBottomInset: false,
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
                      margin: const EdgeInsets.only(top: 170),
                      height: 142,
                      child: Image.asset("assets/images/LogoLightSignup.png"),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 396),
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
                            margin: const EdgeInsets.only(top: 28),
                            height: 28,
                            child: Text(
                              'Get Started',
                              style: Constants.lightThemeTitleTextStyle,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 81),
                            height: 18,
                            child: Text(
                              'Continue with...',
                              style: Constants.roboto15LightThemeTextStyle,
                            ),
                          ),

                          // Social
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 118),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialLoginButton(
                                    _appleLogin,
                                    "Apple",
                                    Image.asset(
                                        "assets/images/AppleLogicIcon.png"),
                                    false),
                                SocialLoginButton(
                                    () => _facebookLogin(ref),
                                    "Facebook",
                                    Image.asset(
                                        "assets/images/FacebookLoginIcon.png"),
                                    false),
                                SocialLoginButton(
                                    () => _googleLogin(ref),
                                    "Google",
                                    Image.asset(
                                        "assets/images/GoogleLoginIcon.png"),
                                    false),
                                SocialLoginButton(
                                    _officeLogin,
                                    "Office 365",
                                    Image.asset(
                                        "assets/images/OfficeLoginIcon.png"),
                                    false)
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 232),
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: Constants.lightThemeDividerColor,
                                  height: 0.5,
                                  width: (screenWidth / 2) - 50,
                                ),
                                Text(
                                  'Or',
                                  style: Constants.roboto15LightThemeTextStyle,
                                ),
                                Container(
                                  color: Constants.lightThemeDividerColor,
                                  height: 0.5,
                                  width: (screenWidth / 2) - 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 260),
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RoundedElevatedButton(
                                    () => _login(context, ref),
                                    "Log in with email",
                                    Constants.lightThemePrimaryColor,
                                    Colors.black,
                                    45),
                                //  LoginButton(),

                                RoundedElevatedButton(
                                    () => _signUp(context),
                                    "Sign up with email",
                                    Constants.blueButtonBackgroundColor,
                                    Colors.white,
                                    45)
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 393, left: 40),
                            // height: 31,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("By continuing you agree to our",
                                    style: Constants
                                        .socialLoginLightButtonTextStyle),
                                TextButton(
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent),
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.transparent)),
                                  onPressed: _openTermsAndConditions,
                                  child: Text(
                                    "privacy policy & terms of use",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                      color: Colors.black.withOpacity(0.6),
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
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
                    Image.asset("assets/images/LoginSignupBackgroundDark.png"),
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 170),
                      height: 142,
                      child: Image.asset("assets/images/LogoLightSignup.png"),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 396),
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
                            margin: const EdgeInsets.only(top: 28),
                            height: 28,
                            child: Text(
                              'Get Started',
                              style: Constants.darkThemeTitleTextStyle,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 81),
                            height: 18,
                            child: Text(
                              'Continue with...',
                              style: Constants.roboto15DarkThemeTextStyle,
                            ),
                          ),

                          // Social
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 118),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SocialLoginButton(
                                    _appleLogin,
                                    "Apple",
                                    Image.asset(
                                        "assets/images/AppleLogicIcon.png"),
                                    true),
                                SocialLoginButton(
                                    () => _facebookLogin(ref),
                                    "Facebook",
                                    Image.asset(
                                        "assets/images/FacebookLoginIcon.png"),
                                    true),
                                SocialLoginButton(
                                    () => _googleLogin(ref),
                                    "Google",
                                    Image.asset(
                                        "assets/images/GoogleLoginIcon.png"),
                                    true),
                                SocialLoginButton(
                                    _officeLogin,
                                    "Office 365",
                                    Image.asset(
                                        "assets/images/OfficeLoginIcon.png"),
                                    true)
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 232),
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  color: Constants.darkThemeDividerColor,
                                  height: 0.5,
                                  width: (screenWidth / 2) - 50,
                                ),
                                Text(
                                  'Or',
                                  style: Constants.roboto15DarkThemeTextStyle,
                                ),
                                Container(
                                  color: Constants.darkThemeDividerColor,
                                  height: 0.5,
                                  width: (screenWidth / 2) - 50,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 260),
                            padding: const EdgeInsets.only(left: 25, right: 25),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RoundedElevatedButton(
                                    () => _login(context, ref),
                                    "Log in with email",
                                    Constants.darkThemePrimaryColor,
                                    Colors.black,
                                    45),
                                RoundedElevatedButton(
                                    () => _signUp(context),
                                    "Sign up with email",
                                    Constants.blueButtonBackgroundColor,
                                    Colors.white,
                                    45)
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 393, left: 40),
                            // height: 31,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("By continuing you agree to our",
                                    style: Constants
                                        .socialLoginDarkButtonTextStyle),
                                TextButton(
                                    style: ButtonStyle(
                                        overlayColor: MaterialStateProperty.all(
                                            Colors.transparent),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.transparent)),
                                    onPressed: _openTermsAndConditions,
                                    child: Text(
                                      "privacy policy & terms of use",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.white.withOpacity(0.6),
                                        decoration: TextDecoration.underline,
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      );
    });
  }
}
