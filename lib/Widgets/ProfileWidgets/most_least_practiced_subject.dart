import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../app.dart';
import '../../../Models/class_datasource.dart';
import '../../../Utilities/constants.dart';

class MostLeastPracticedSubject extends ConsumerWidget {
  final int cardIndex;
  final String mostPracticedSubject;
  final Color mostPracticedSubjectColor;
  final int mostPracticedSubjectTasksCount;
  final String leastPracticedSubject;
  final Color leastPracticedSubjectColor;
  final int leastPracticedSubjectTasksCount;

  final Function cardselected;

  MostLeastPracticedSubject({
    super.key,
    required this.cardIndex,
    required this.cardselected,
    required this.mostPracticedSubject,
    required this.mostPracticedSubjectColor,
    required this.mostPracticedSubjectTasksCount,
    required this.leastPracticedSubject,
    required this.leastPracticedSubjectColor,
    required this.leastPracticedSubjectTasksCount
  });

  void _cardTapped() {
    cardselected(cardIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 6),
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
            height: 152,
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("Most Practiced Subject",
                          style: theme == ThemeMode.light
                              ? Constants.lightTHemeClassDateTextStyle
                              : Constants.darkTHemeClassDateTextStyle),
                    ),
                    Container(
                      child: Text("Tasks this month",
                          style: theme == ThemeMode.light
                              ? Constants.socialLoginLightButtonTextStyle
                              : Constants.socialLoginDarkButtonTextStyle),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        mostPracticedSubject,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'BebasNeue',
                            fontWeight: FontWeight.normal,
                            color: mostPracticedSubjectColor),
                      ),
                    ),
                    Container(
                      child: Text("$mostPracticedSubjectTasksCount",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Colors.black
                                : Colors.white)),
                    ),
                  ],
                ),
                Container(
                  height: 12,
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text("Least Practiced Subject",
                          style: theme == ThemeMode.light
                              ? Constants.lightTHemeClassDateTextStyle
                              : Constants.darkTHemeClassDateTextStyle),
                    ),
                    Container(
                      child: Text("Tasks this month",
                          style: theme == ThemeMode.light
                              ? Constants.socialLoginLightButtonTextStyle
                              : Constants.socialLoginDarkButtonTextStyle),
                    ),
                  ],
                ),
                  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                        leastPracticedSubject,
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'BebasNeue',
                            fontWeight: FontWeight.normal,
                            color: leastPracticedSubjectColor),
                      ),
                    ),
                    Container(
                      child: Text("$leastPracticedSubjectTasksCount",
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Colors.black
                                : Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
