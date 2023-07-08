import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../app.dart';
import '../../Models/class_datasource.dart';
import '../../Utilities/constants.dart';
import '../../Models/task_datasource.dart';
import '../../Models/API/task.dart';

class TaskWidget extends ConsumerWidget {
  final int cardIndex;
  final bool upNext;

  final Task taskItem;
  final Function cardselected;

  const TaskWidget(
      {super.key,
      required this.taskItem,
      required this.cardIndex,
      required this.upNext,
      required this.cardselected});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  String _getFormattedTime(DateTime time) {
    var localDate = time.toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    var outputFormat = DateFormat('dd MMM');
    var outputDate = outputFormat.format(inputDate);
    return outputDate.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    double percentageProgress = (taskItem.progress ?? 0 / 10) * 100;
    DateTime? dueDate = taskItem.getTaskDueDateTime();
    bool duePassed = false;
    int daysPassed = 0;
   // var localDate = dueDate.toLocal();
    if (dueDate.isBefore(DateTime.now())) {
      duePassed = true;
      daysPassed = dueDate.daysBetween(dueDate, DateTime.now());
    }

    return Card(
      margin: const EdgeInsets.only(top: 6, bottom: 6, right: 20, left: 20),
      color: theme == ThemeMode.light
          ? Colors.white
          : Constants.darkThemeSecondaryBackgroundColor,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: _cardTapped,
        child: Container(
          height: 143,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 18, top: 18, bottom: 18, right: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      taskItem.details ?? "",
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeUpNextBannerTextStyle
                          : Constants.darkThemeUpNextBannerTextStyle,
                    ),
                    Text(
                      taskItem.subject?.subjectName ?? "",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.normal,
                          color: taskItem.subject?.colorHex != null
                              ? HexColor.fromHex(taskItem.subject!.colorHex!)
                              : Colors.red),
                    ),
                    Text(
                      taskItem.type ?? "",
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeTaskSubjectStyle
                          : Constants.darkThemeTaskSubjectStyle,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      //  crossAxisAlignment: CrossAxisAlignment,
                      children: [
                        Text(
                          '${percentageProgress}%',
                          style: theme == ThemeMode.light
                              ? Constants.lightThemeTaskSubjectStyle
                              : Constants.darkThemeTaskSubjectStyle,
                        ),
                        Container(
                          width: 8,
                        ),
                        Container(
                          width: 76,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            // shape: BoxShape.circle
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            child: LinearProgressBar(
                              maxSteps: 10,
                              progressType:
                                  LinearProgressBar.progressTypeLinear,
                              currentStep: taskItem.progress ?? 0,
                              progressColor: Constants.lightThemePrimaryColor,
                              backgroundColor: Colors.black.withOpacity(0.1),
                              minHeight: 6,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Positioned(
              //   right: 0,
              //   child: Container(
              //     height: 141,
              //     width: 143,
              //     child: FittedBox(
              //       fit: BoxFit.fill,
              //       child: Image.asset(
              //         taskItem.subjectImage,
              //       ),
              //     ),
              //   ),
              // ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: Container(
                  margin: EdgeInsets.all(0),
                  height: 141,
                  width: 143,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: Image.network(
                      fit: BoxFit.fill,
                      taskItem.subject?.imageUrl ?? "",
                      height: 114,
                      width: 143,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 45,
                bottom: 0,
                top: 0,
                child: Container(
                  height: 141.0,
                  width: 98,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                      begin: FractionalOffset.centerRight,
                      end: FractionalOffset.centerLeft,
                      colors: theme == ThemeMode.light
                          ? [Colors.white.withOpacity(0.0), Colors.white]
                          : [
                              Constants.darkThemeSecondaryBackgroundColor
                                  .withOpacity(0.0),
                              Constants.darkThemeSecondaryBackgroundColor
                            ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                ),
              ),
              // Positioned(
              //   right: 45,
              //   child: Container(
              //     height: 141.0,
              //     width: 98,
              //     decoration: BoxDecoration(
              //       color: Colors.white,
              //       gradient: LinearGradient(
              //         begin: FractionalOffset.centerRight,
              //         end: FractionalOffset.centerLeft,
              //         colors: theme == ThemeMode.light
              //             ? [Colors.white.withOpacity(0.0), Colors.white]
              //             : [
              //                 Constants.darkThemeSecondaryBackgroundColor
              //                     .withOpacity(0.0),
              //                 Constants.darkThemeSecondaryBackgroundColor
              //               ],
              //         stops: const [0.0, 1.0],
              //       ),
              //     ),
              //   ),
              // ),
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                    color: duePassed
                        ? Constants.darkThemeSecondaryBackgroundColor
                        : Colors.white,
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomLeft: Radius.circular(10.0),
                    ),
                  ),
                  width: 83,
                  alignment: Alignment.center,
                  padding:
                      EdgeInsets.only(left: 6, right: 6, top: 6, bottom: 6),
                  child: Text(
                    duePassed
                        ? "${daysPassed} days"
                        : _getFormattedTime(dueDate),
                    style: duePassed
                        ? TextStyle(
                            fontSize: 14,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Constants.taskDueBannerColor)
                        : Constants.lightThemeUpNextBannerTextStyle,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
