import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';

class RowSwitchSpaceAround extends StatelessWidget {
  final String title;
  final bool isOn;
  final Function changedState;
  final int index;
  final bool bottomBorderOn;
  const RowSwitchSpaceAround(
      {super.key,
      required this.title,
      required this.isOn,
      required this.changedState,
      required this.index, required this.bottomBorderOn});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        margin: const EdgeInsets.only(left: 40, right: 40),
        height: 58,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              width: 1.0,
              color: theme == ThemeMode.light
                  ? Colors.black.withOpacity(0.15)
                  : Colors.white.withOpacity(0.15),
            ),
            bottom: BorderSide(
              width: 1.0 ,
              color: bottomBorderOn ? theme == ThemeMode.light
                  ? Colors.black.withOpacity(0.15)
                  : Colors.white.withOpacity(0.15) : Colors.transparent,
            ),
          ),
         // color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
             mainAxisSize: MainAxisSize.max,
          children: [  
            Container(
              height: 10,
            ),
            Text(
              title,
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
            ),
            const Spacer(),
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
            Container(
              height: 10,
            ),
          ],
        ),
      );
    });
  }
}
