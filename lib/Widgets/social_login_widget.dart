import 'package:flutter/material.dart';
import '../Utilities/constants.dart';

class SocialLoginButton extends StatelessWidget {
  final VoidCallback selectHandler;
  final String buttonTitle;
  final Image buttonIcon;
  final bool isDarkMode;

  const SocialLoginButton(this.selectHandler, this.buttonTitle, this.buttonIcon, this.isDarkMode,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              splashRadius: 100,
              iconSize: 58,
              icon: buttonIcon,
              onPressed: selectHandler),
          Container(
            alignment: Alignment.center,
            height: 14,
            child: Text(
              buttonTitle,
              style: isDarkMode ? Constants.socialLoginDarkButtonTextStyle : Constants.socialLoginLightButtonTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
