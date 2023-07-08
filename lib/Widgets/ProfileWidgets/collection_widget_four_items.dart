import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../app.dart';
import '../../../Models/class_datasource.dart';
import '../../../Utilities/constants.dart';

class CollectionWidgetFourItems extends ConsumerWidget {
  final int cardIndex;
  final String title;
  final String subtitle;
  final int numberFirst;
  final bool isOverdue;
  final bool isPending;
  final bool isTasksOrStreak;

  final Function cardselected;

  int? numberSecond;

  CollectionWidgetFourItems(
      {super.key,
      required this.title,
      required this.cardIndex,
      required this.cardselected,
      required this.subtitle,
      required this.numberFirst,
      required this.isOverdue,
      required this.isPending,
      required this.isTasksOrStreak,
      this.numberSecond});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5.0),
          topLeft: Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: theme == ThemeMode.light
                ? Colors.black.withOpacity(0.08)
                : Colors.white.withOpacity(0.08),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.all(5),
        color: theme == ThemeMode.light
            ? Colors.white
            : Constants.darkThemeSecondaryBackgroundColor,
        shadowColor: Colors.transparent,
        // elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: InkWell(
          onTap: _cardTapped,
          child: Container(
            height: 149,
            padding: EdgeInsets.only(top: 18, bottom: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Text(title,
                      style: theme == ThemeMode.light
                          ? Constants.lightTHemeClassDateTextStyle
                          : Constants.darkTHemeClassDateTextStyle),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 4),
                    child: Text(
                      textAlign: TextAlign.center,
                      subtitle,
                      maxLines: 2,
                      style: theme == ThemeMode.light
                          ? Constants.socialLoginLightButtonTextStyle
                          : Constants.socialLoginDarkButtonTextStyle,
                    ),
                  ),
                ),
                if (isPending) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: RichText(
                      text: TextSpan(
                        text: '$numberFirst',
                        style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Colors.black
                                : Colors.white),
                        children: [
                          TextSpan(
                            text: ' / $numberSecond',
                            style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              color: theme == ThemeMode.light
                                  ? Colors.black.withOpacity(0.5)
                                  : Colors.white.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 121,
                    height: 18,
                    decoration: BoxDecoration(
                      color: theme == ThemeMode.light
                          ? Colors.black.withOpacity(0.2)
                          : Colors.white.withOpacity(0.2),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10.0),
                      ),
                      // shape: BoxShape.circle
                    ),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: LinearProgressBar(
                        maxSteps: numberSecond ?? 10,
                        progressType: LinearProgressBar.progressTypeLinear,
                        currentStep: numberFirst,
                        progressColor: Constants.lightThemePrimaryColor,
                        backgroundColor: theme == ThemeMode.light
                            ? Colors.black.withOpacity(0.2)
                            : Colors.white.withOpacity(0.2),
                        minHeight: 18,
                      ),
                    ),
                  ),
                ],
                if (isOverdue) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      '$numberFirst',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: Constants.overdueTextColor,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'View',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.normal,
                        color: theme == ThemeMode.light
                            ? Constants.blueButtonBackgroundColor
                            : Constants.darkThemePrimaryColor,
                      ),
                    ),
                  ),
                ],
                if (isTasksOrStreak) ...[
                  Container(
                    margin: const EdgeInsets.only(bottom: 15),
                    child: Text(
                      '$numberFirst',
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: theme == ThemeMode.light
                            ? Colors.black
                            : Colors.white,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
