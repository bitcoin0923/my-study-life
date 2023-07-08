import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import '../Models/exam_datasource.dart';
import '../Models/API/exam.dart';
import '../Models/API/event.dart';

class ExamWidget extends ConsumerWidget {
  final int cardIndex;
  final bool upNext;

  final Exam? examItem;
  final Event? eventItem;
  final Function cardselected;

  const ExamWidget(
      {super.key,
      this.examItem,
      this.eventItem,
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
          height: 142,
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
                      eventItem == null
                          ? examItem?.subject?.subjectName ?? "".toUpperCase()
                          : eventItem?.subject?.subjectName ?? "".toUpperCase(),
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'BebasNeue',
                          fontWeight: FontWeight.normal,
                          color: eventItem == null
                              ? examItem?.subject?.colorHex != null
                                  ? HexColor.fromHex(
                                      examItem!.subject!.colorHex!)
                                  : Colors.red
                              : eventItem?.subject?.colorHex != null
                                  ? HexColor.fromHex(
                                      eventItem!.subject!.colorHex!)
                                  : Colors.red),
                    ),
                    Expanded(
                      child: Text(
                        eventItem == null
                            ? examItem?.module ?? ""
                            : eventItem?.module ?? "",
                        maxLines: 4,
                        style: theme == ThemeMode.light
                            ? Constants.socialLoginLightButtonTextStyle
                            : Constants.socialLoginDarkButtonTextStyle,
                      ),
                    ),
                    Text(
                      eventItem == null
                          ? '${examItem?.getExamStartFormattedDate()}'
                          : '${eventItem?.getFormattedStartingDate()}',
                      style: theme == ThemeMode.light
                          ? Constants.lightTHemeClassDateTextStyle
                          : Constants.darkTHemeClassDateTextStyle,
                    ),
                    Text(
                      eventItem == null
                          ? '${(examItem?.duration ?? 1 * 60)} Minutes - ${examItem?.type}'
                          : '${(eventItem?.duration ?? 1 * 60)} Minutes - ${eventItem?.mode}',
                      style: theme == ThemeMode.light
                          ? Constants.socialLoginLightButtonTextStyle
                          : Constants.socialLoginDarkButtonTextStyle,
                    ),
                  ],
                ),
              ),
              Positioned(
                right: 0,
                bottom: 0,
                top: 0,
                child: Container(
                  margin: EdgeInsets.all(0),
                  height: 142,
                  width: 143,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10), // Image border
                    child: Image.network(
                      fit: BoxFit.fill,
                      eventItem == null
                          ? examItem?.subject?.imageUrl ?? ""
                          : eventItem?.subject?.imageUrl ?? "",
                      height: 142,
                      width: 143,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 45,
                child: Container(
                  height: 142.0,
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
            ],
          ),
        ),
      ),
    );
  }
}
