import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';

import '../app.dart';
import '../Models/tasks_due_dataSource.dart';
import '../Utilities/constants.dart';

class TaskDueCardForClassOrExam extends ConsumerWidget {
  final int cardIndex;

  final TaskDueStatic taskDueItem;
  final Function cardselected;

  const TaskDueCardForClassOrExam(
      this.cardIndex, this.taskDueItem, this.cardselected,
      {super.key});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  String _getFormattedTime(DateTime time) {
    var localDate = time.toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    if (time.isToday()) {
      var outputFormat = DateFormat('HH:mm');
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      var outputFormat = DateFormat('EEE, d MMM ');
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
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
          height: 121,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 20, top: 16, bottom: 18, right: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(taskDueItem.title,
                          maxLines: 4,
                          style: theme == ThemeMode.light
                              ? Constants.lightThemeTaskDueDescriptionTextStyle
                              : Constants.darkThemeTaskDueDescriptionTextStyle),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(taskDueItem.subject,
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeTaskSubjectStyle
                                : Constants.darkThemeTaskSubjectStyle),

                        Text('Due ${_getFormattedTime(taskDueItem.dueDate)}',
                            style: theme == ThemeMode.light
                                ? Constants.lightThemeTaskDueDatetStyle
                                : Constants.darkThemeTaskDueDatetStyle),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                left: 0,
                top: 17,
                child: Container(
                  height: 29,
                  width: 3,
                  decoration: BoxDecoration(
                    color: taskDueItem.subjectColor,
                      border: Border.all(
                        color: taskDueItem.subjectColor,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
