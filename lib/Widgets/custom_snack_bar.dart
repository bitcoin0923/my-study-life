import 'package:flutter/material.dart';
import '../Utilities/constants.dart';
import '../app.dart';
// import 'package:calibrex_flutter_v2/helpers/my_constants.dart';

enum CustomSnackBarType {
  error,
  info,
  success,
}

class CustomSnackBar {
  CustomSnackBar._();

  static show(BuildContext context, CustomSnackBarType type, String message, bool isHome) {
    // SnackBar text and icon color
    final Color textColor =
        type == CustomSnackBarType.success ? Colors.black : Colors.white;

    // SnackBar text style
    final textStyle = TextStyle(
      height: 1.5,
      fontSize: 13,
      color: textColor,
      fontWeight: FontWeight.w500,
      fontFamily: 'Roboto',
    );

    // SnackBar rounded conrers
    final shape = RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(14),
    );

    // SnackBar position
    int distanceFromTop = 150;

    if (isHome) {
      distanceFromTop = 210;
    }

    final margin = EdgeInsets.only(
      bottom: (MediaQuery.of(context).size.height -
          distanceFromTop -
          MediaQuery.of(context).viewPadding.top),
      right: 16,
      left: 16,
    );

    // SnackBar Background
    Color backgroundColor() {
      switch (type) {
        case CustomSnackBarType.error:
          return Colors.red;
        case CustomSnackBarType.info:
          return Colors.blue;
        case CustomSnackBarType.success:
          return Colors.green;
      }
    }

    // Show Snack Bar
   scaffoldMessengerKey.currentState!.showSnackBar(
      SnackBar(
        shape: shape,
        margin: margin,
        showCloseIcon: false,
        closeIconColor: textColor,
        backgroundColor: backgroundColor(),
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        dismissDirection: DismissDirection.up,
        content: Text(
          message,
          style: textStyle,
        ),
      ),
    );
  }
}
