import 'package:flutter/material.dart';
import '../Extensions/extensions.dart';

class Constants {
//Keys
  static String homeRouteName = 'home';
  static String loggedInKey = 'LoggedIn';
  static String loginRouteName = 'login';
  static String rootRouteName = 'root';
  static String registerRouteName = 'register';
  static String getStartedRouteName = 'getStarted';
  static String forgotPasswordRouteName = 'forgotPassword';
  static String searchRouteName = 'searchRoute';
  static String classDetailsRouteName = 'classDetails';
  static String createScreenRouteName = 'createScreen';

//Colors
  static Color lightThemeBackgroundColor = Colors.white;
  static Color darkThemeBackgroundColor = HexColor.fromHex("#1E2439");
  static Color lightThemeCalendaryDayColor = HexColor.fromHex("#1E2022");
  static Color darkThemeSecondaryBackgroundColor = HexColor.fromHex("#283153");
  static Color lightThemePrimaryColor = HexColor.fromHex('#00F6FF');
  static Color darkThemePrimaryColor = HexColor.fromHex('#00F6FF');
  static Color lightThemeSecondaryColor =
      HexColor.fromHex('#00F6FF').withOpacity(0.2);
  static Color darkThemeSecondaryColor = HexColor.fromHex('#707070');
  static Color lightThemeTextPrimaryColor = Colors.black;
  static Color lightThemeTextSecondaryColor = Colors.black.withOpacity(0.5);
  static Color darkThemeTextPrimaryColor = Colors.white;
  static Color darkThemeTextSecondaryColor = Colors.white.withOpacity(0.5);
  static Color lightThemeTextSelectionColor = HexColor.fromHex("#0F116C");
  static Color darkThemeTextSelectionColor = HexColor.fromHex('#00F6FF');
  static Color darkThemeNavigationBarColor = HexColor.fromHex('#1A1B21');
  static Color lightThemeUnselectedTextColor = Colors.black.withOpacity(0.7);
  static Color darkThemeUnselectedTextColor = Colors.white.withOpacity(0.5);
  static Color darkThemeDividerColor = Colors.white.withOpacity(0.2);
  static Color lightThemeDividerColor = Colors.black.withOpacity(0.2);
  static Color blueButtonBackgroundColor = HexColor.fromHex("#005ED3");
  static Color lightThemeBorderColor = HexColor.fromHex("#CACCD5");
  static Color lightThemeNotSelectedItemColor =
      HexColor.fromHex('#00F6FF').withOpacity(0.2);
  static Color darkThemeNotSelectedItemColor = Colors.white.withOpacity(0.2);
  static Color classColor = HexColor.fromHex("#0EA8A2");
  static Color lightThemeUpNextBannerBackgroundColor = Colors.white;
  static Color darkThemeUpNextBannerBackgroundColor =
      HexColor.fromHex("#0F116C");
  static Color taskDueBannerColor = HexColor.fromHex("#FF6705");
  static Color darkThemeInactiveSwitchColor = HexColor.fromHex("#414C71");
  static Color lightThemeInactiveSwitchColor = HexColor.fromHex("#E1EAF1");
  static Color darkThemeClassExamCardBackgroundColor =
      HexColor.fromHex("#273052");
  static Color lightThemeClassExamDetailsBackgroundColor =
      HexColor.fromHex("#F5F9FC");
  static Color lightThemeScoreBackgroundColor = HexColor.fromHex("#00DEFF");
  static Color lightThemeAddScoreBackgroundColor =
      HexColor.fromHex("#00DEFF").withOpacity(0.15);
  static Color darkThemeAddScoreBackgroundColor =
      Colors.white.withOpacity(0.15);
  static Color darkThemeTaskTypeColorColor =
      HexColor.fromHex("#72788E").withOpacity(0.7);
  static Color lightThemeProfileImageCntainerColor =
      HexColor.fromHex("#F2F2F5");
  static Color darkThemeProfileImageCntainerColor = Colors.black;
  static Color overdueTextColor = HexColor.fromHex("#FF3B3B");
  static Color logOutButtonColor = HexColor.fromHex("#FFB9B9");
  static Color dayCalendarHourColor = HexColor.fromHex("#576E82");
  static Color dayCalendarLineColor = HexColor.fromHex("#A9BBC9");
  static Color weekCalendarOddDayLightBackround = HexColor.fromHex("#F0F4F5");
  static Color weekCalendarOddDayDarkBackround = HexColor.fromHex("#161A29");

  static Color weekCalendarNormalDayLightBackround = Colors.white;
  static Color weekCalendarNormalDayDarkBackround = HexColor.fromHex("#1E2439");
  static Color calendarLegendClassBlueColor = HexColor.fromHex("#3224A0");
  static Color calendarLegendExamColor = HexColor.fromHex("#E9E7F7");
  static Color diagonalColorPainter = HexColor.fromHex("#BFC1D6");
  static Color calendarLegendPrepTextColor = HexColor.fromHex("#C1C0D8");


  

  static const MaterialColor kToLight = MaterialColor(
    0xffffffff, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xffe6e6e6), //10%
      100: Color(0xffcccccc), //20%
      200: Color(0xffb3b3b3), //30%
      300: Color(0xff999999), //40%
      400: Color(0xff808080), //50%
      500: Color(0xff666666), //60%
      600: Color(0xff4c4c4c), //70%
      700: Color(0xff333333), //80%
      800: Color(0xff191919), //90%
      900: Color(0xff000000), //100%
    },
  );

  static const MaterialColor kToDark = MaterialColor(
    0xff1e2439, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    <int, Color>{
      50: Color(0xff1b2033), //10%
      100: Color(0xff181d2e), //20%
      200: Color(0xff151928), //30%
      300: Color(0xff121622), //40%
      400: Color(0xff0f121d), //50%
      500: Color(0xff0c0e17), //60%
      600: Color(0xff090b11), //70%
      700: Color(0xff06070b), //80%
      800: Color(0xff030406), //90%
      900: Color(0xff000000), //100%
    },
  );

//Fonts
  static TextStyle lightThemeTitleTextStyle = TextStyle(
      fontSize: 24,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: lightThemeTextPrimaryColor);

  static TextStyle darkThemeTitleTextStyle = TextStyle(
      fontSize: 24,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: darkThemeTextPrimaryColor);

  static TextStyle lightThemeTodayDateTextStyle = TextStyle(
      fontSize: 36,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      color: lightThemeTextPrimaryColor);

  static TextStyle darkThemeTodayDateTextStyle = TextStyle(
      fontSize: 36,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w300,
      color: darkThemeTextPrimaryColor);

  static TextStyle titleTextStyle = const TextStyle(
    fontSize: 24,
    fontFamily: 'Roboto',
    fontWeight: FontWeight.bold,
  );

  static TextStyle roboto15LightThemeTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black.withOpacity(0.6));

  static TextStyle roboto15NormalWhiteTextStyle = const TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white);

  static TextStyle roboto15DarkThemeTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white.withOpacity(0.6));

  static TextStyle socialLoginDarkButtonTextStyle = TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white.withOpacity(0.6));

  static TextStyle socialLoginLightButtonTextStyle = TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black.withOpacity(0.6));

  static TextStyle lightThemeTextButtonTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: blueButtonBackgroundColor);

  static TextStyle darkThemeTextButtonTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: darkThemePrimaryColor);

  static TextStyle lightThemeGreetingMessageStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: lightThemeTextPrimaryColor);

  static TextStyle darkThemeGreetingMessageStyle = TextStyle(
      fontSize: 16,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: darkThemeTextPrimaryColor);

  static TextStyle tabItemBadgeTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w900,
      color: lightThemeTextSelectionColor);

  static TextStyle lightThemeDetailsDateStyle = TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: lightThemeTextSelectionColor);

  static TextStyle darkThemeDetailsDateStyle = const TextStyle(
      fontSize: 20,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white);

  static TextStyle tabItemTitleTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: lightThemeTextSelectionColor);

  static TextStyle darkThemeInfoSubtitleTextStyle = const TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white);

  static TextStyle lightThemeUpNextBannerTextStyle = TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: lightThemeTextSelectionColor);

  static TextStyle darkThemeUpNextBannerTextStyle = const TextStyle(
      fontSize: 15,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static TextStyle taskDueBannerTextStyle = const TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static TextStyle lightTHemeClassDateTextStyle = const TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static TextStyle darkTHemeClassDateTextStyle = const TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static TextStyle lightThemeTabBarTextStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: blueButtonBackgroundColor);

  static TextStyle darkThemeTabBarTextStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: darkThemePrimaryColor);

  static TextStyle lightThemeSubtitleTextStyle = const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static TextStyle darkThemeTaskDueDescriptionTextStyle = const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static TextStyle lightThemeTaskDueDescriptionTextStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: lightThemeTextSelectionColor);

  static TextStyle darkThemeSubtitleTextStyle = const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.white);

  static TextStyle lightThemeMedium14TextStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: lightThemeTextSelectionColor);
      
  static TextStyle darkThemeMedium14TextStyle = const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: Colors.white);

  static TextStyle lightThemeRegular14TextStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: lightThemeTextSelectionColor);

  static TextStyle darkThemeRegular14TextStyle = const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white);

  static TextStyle lightThemeRegular14TextSelectedStyle = const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black);

  static TextStyle darkThemeRegular14TextSelectedStyle = const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black);

  static TextStyle lightThemeRegular14HalfOppacityTextSelectedStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black.withOpacity(0.5));

  static TextStyle darkThemeRegular14HalfOppacityTextSelectedStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white.withOpacity(0.5));

  static TextStyle lightThemeMedium14SelectedTextStyle = const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: Colors.black);

  static TextStyle darkThemeMedium14SelectedTextStyle = const TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.w500,
      color: Colors.black);

  static TextStyle lightThemePhotoDescriptionStyle = TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: darkThemeUpNextBannerBackgroundColor);

  static TextStyle darkThemePhotoDescriptionStyle = TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white.withOpacity(0.7));

  static TextStyle darkThemeTaskSubjectStyle = TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white.withOpacity(0.4));

  static TextStyle lightThemeTaskSubjectStyle = TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black.withOpacity(0.4));

  static TextStyle darkThemeTaskDueDatetStyle = const TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white);

  static TextStyle lightThemeTaskDueDatetStyle = const TextStyle(
      fontSize: 12,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black);

  static TextStyle darkThemeNavigationButtonStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: darkThemePrimaryColor);

  static TextStyle lightThemeNavigationButtonStyle = TextStyle(
      fontSize: 14,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: blueButtonBackgroundColor);

  static TextStyle lightThemeRegular10TextSelectedStyle = const TextStyle(
      fontSize: 10,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black);

  static TextStyle darkThemeRegular10TextSelectedStyle = const TextStyle(
      fontSize: 10,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white);

  static TextStyle lightThemeRegular10TextSelectedStyleWithOpacity = TextStyle(
      fontSize: 10,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.black.withOpacity(0.4));

  static TextStyle darkThemeRegular10TextSelectedStyleWithOpacity = TextStyle(
      fontSize: 10,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.normal,
      color: Colors.white.withOpacity(0.4));

  static TextStyle lightThemeRegular8TextSelectedStyle = const TextStyle(
      fontSize: 8,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.black);

  static TextStyle darkThemeRegular8TextSelectedStyle = const TextStyle(
      fontSize: 8,
      fontFamily: 'Roboto',
      fontWeight: FontWeight.bold,
      color: Colors.white);

      
}
