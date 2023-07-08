import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Models/API/classmodel.dart';

import '../../app.dart';

class ClassExamDetailsInfoCard extends ConsumerWidget {
  final Color mainGradientColor;
  final String type;
  final String subjectName;
  final String subjectOrExamTheme;
  final String? dateFrom;
  final String? dateTo;
  const ClassExamDetailsInfoCard(this.mainGradientColor, this.type,
      this.subjectName, this.subjectOrExamTheme, this.dateFrom, this.dateTo,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    return Container(
      height: 154,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 175),
      decoration: BoxDecoration(
        // border: Border.all(
        //   color: theme == ThemeMode.light
        //       ? Colors.white
        //       : Constants.darkThemeClassExamCardBackgroundColor,
        // ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.center,
          stops: const [
            0.1,
            0.9,
          ],
          colors: [
            mainGradientColor,
            theme == ThemeMode.light
                ? Colors.white
                : Constants.darkThemeClassExamCardBackgroundColor,
          ],
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            // Type
            right: 0,
            top: 25,
            child: Container(
              height: 25,
              width: 52,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(4.0),
                  bottomLeft: Radius.circular(4.0),
                ),
                color: Constants.blueButtonBackgroundColor,
              ),
              child: Text(
                type,
                style: Constants.roboto15NormalWhiteTextStyle,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title
                Text(
                  subjectName,
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: mainGradientColor,
                  ),
                ),
                // Theme
                Text(
                  subjectOrExamTheme,
                  style: theme == ThemeMode.light
                      ? Constants.tabItemTitleTextStyle
                      : Constants.darkThemeInfoSubtitleTextStyle,
                ),
                Container(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "".getFormattedDateClass(dateFrom ?? ""),
                      //dateFrom.getFormattedDate(dateFrom),
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeDetailsDateStyle
                          : Constants.darkThemeDetailsDateStyle,
                    ),
                    Container(
                      height: 24,
                      width: 1,
                      color: theme == ThemeMode.light
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.2),
                    ),
                    Text(
                      "".getFormattedTimeClass(dateTo ?? "", context),
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeDetailsDateStyle
                          : Constants.darkThemeDetailsDateStyle,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
