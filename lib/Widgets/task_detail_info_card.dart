import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Models/API/task.dart';
import '../../app.dart';

class TaskDetailsInfoCard extends ConsumerWidget {
  final Task taskItem;
  const TaskDetailsInfoCard(this.taskItem, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    DateTime? dueDate = DateTime.tryParse(taskItem.dueDate ?? "");
    bool duePassed = false;
    int daysPassed = 0;
    if (dueDate != null) {
      var localDate = dueDate.toLocal();
      daysPassed = localDate.daysBetween(dueDate, DateTime.now());
      if (localDate.isBefore(DateTime.now())) {
        duePassed = true;
      }
    }

    return Container(
      height: 240,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 175),
      decoration: BoxDecoration(
        // gradient: LinearGradient(
        //   begin: Alignment.topCenter,
        //   end: Alignment.center,
        //   stops: const [
        //     0.1,
        //     0.9,
        //   ],
        //   colors: [
        //     mainGradientColor,
        //     theme == ThemeMode.light
        //         ? Colors.white
        //         : Constants.darkThemeClassExamCardBackgroundColor,
        //   ],
        // ),
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 57,
            margin: const EdgeInsets.only(top: 176),
            decoration: BoxDecoration(
              color: theme == ThemeMode.light
                  ? Constants.taskDueBannerColor.withOpacity(0.12)
                  : Constants.overdueTextColor.withOpacity(0.12),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Container(
              alignment: Alignment.bottomCenter,
              margin: const EdgeInsets.only(bottom: 10),
              child: Text(
                duePassed
                    ? "Overdue by ${daysPassed} days"
                    : "Due in ${daysPassed} days",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                  color: Constants.overdueTextColor,
                ),
              ),
            ),
          ),
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: theme == ThemeMode.light
                  ? Colors.white
                  : Constants.darkThemeClassExamCardBackgroundColor,
              borderRadius: BorderRadius.all(
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
                      taskItem.type ?? "",
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
                      // Description
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Text(
                             taskItem.details ?? "",
                            maxLines: 4,
                            style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light ? Constants.lightThemeTextSelectionColor : Colors.white,
                          ),
                          ),
                        ),
                      ),
                      Container(
                        height: 10,
                      ),
                      // Title
                      Text(
                        taskItem.subject?.subjectName ?? "",
                        style: TextStyle(
                          fontSize: 36,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: taskItem.subject?.colorHex != null
                              ? HexColor.fromHex(taskItem.subject!.colorHex!)
                              : Colors.red,
                        ),
                      ),
                      // Theme
                      Text(
                        taskItem.category ?? "",
                        style: theme == ThemeMode.light
                            ? Constants.tabItemTitleTextStyle
                            : Constants.darkThemeInfoSubtitleTextStyle,
                      ),
                      Container(
                        height: 20,
                      ),
                      Text(
                        "".getFormattedDateClass(taskItem.dueDate ?? ""),
                        //dateFrom.getFormattedDate(dateFrom),
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeDetailsDateStyle
                            : Constants.darkThemeDetailsDateStyle,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
