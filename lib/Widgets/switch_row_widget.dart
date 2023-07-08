import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';

class RowSwitch extends StatelessWidget {
  final String title;
  final bool isOn;
  final Function changedState;
  final int index;
  const RowSwitch(
      {super.key,
      required this.title,
      required this.isOn,
      required this.changedState, required this.index});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        margin: const EdgeInsets.only(left: 40, right: 40),
        height: 34,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
            ),
            CupertinoSwitch(
              value: isOn,
              onChanged: (value) => changedState(value, index),
              activeColor: theme == ThemeMode.light
                  ? Constants.lightThemePrimaryColor
                  : Constants.darkThemePrimaryColor,
              thumbColor: Colors.white,
              trackColor: theme == ThemeMode.light
                  ? Constants.lightThemeInactiveSwitchColor
                  : Constants.darkThemeInactiveSwitchColor,
            ),
          ],
        ),
      );
    });
  }
}
