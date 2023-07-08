import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import './horizontal_week_calendar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Models/API/event.dart';
import '../../Utilities/constants.dart';
import 'package:intl/intl.dart';
import '../../Extensions/extensions.dart';
import '../../Models/API/classmodel.dart';
import '../../Home_Screens/class_details_screen.dart';
import '../../Models/API/exam.dart';
import '../../Home_Screens/exam_details_screen.dart'; 

class DayViewWidget extends StatefulWidget {
  final GlobalKey<DayViewState>? state;
  final double? width;
  final Function daySelected;
  final Function pageChanged;
  final DateTime selectedDay;

  const DayViewWidget({
    Key? key,
    this.state,
    this.width,
    required this.daySelected,
    required this.pageChanged,
    required this.selectedDay,
  }) : super(key: key);

  @override
  State<DayViewWidget> createState() => _DayViewWidgetState();
}

class _DayViewWidgetState extends State<DayViewWidget> {
  // static GlobalKey<DayViewState> dayViewStateKey = GlobalKey<DayViewState>();
  // final GlobalKey weekViewStateKey = GlobalKey();

   void _openClassDetails(Event eventItem) {
    var classModel = ClassModel(
        id: eventItem.id,
        module: eventItem.module,
        mode: eventItem.mode,
        room: eventItem.room,
        building: eventItem.building,
        onlineUrl: eventItem.onlineUrl,
        teacher: eventItem.teacher,
        teachersEmail: eventItem.teachersEmail,
        occurs: eventItem.occurs,
        days: eventItem.days,
        startDate: eventItem.startDate,
        endDate: eventItem.endDate,
        startTime: eventItem.startTime,
        endTime: eventItem.endTime,
        createdAt: eventItem.createdAt,
        subject: eventItem.subject);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClassDetailsScreen(classModel),
            fullscreenDialog: true));
  }

  void _openExamDetails(Event eventItem) {
    var examItem = Exam(
        id: eventItem.id,
        resit: eventItem.resit,
        module: eventItem.module,
        mode: eventItem.mode,
        onlineUrl: eventItem.onlineUrl,
        room: eventItem.room,
        seat: eventItem.seat,
        startDate: eventItem.startDate,
        startTime: eventItem.startTime,
        duration: eventItem.duration,
        createdAt: eventItem.createdAt);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExamDetailsScreen(examItem: examItem),
            fullscreenDialog: true));
  }

  // Event tile creation
  Container createEventTileContainer(
      DateTime date,
      List<CalendarEventData<Event>> events,
      DateTime startDuration,
      DateTime endDuration,
      ThemeMode theme) {
    final CalendarEventData<Event> finalEvent =
        events.firstWhere((element) => element.startTime == startDuration);
    final startHourString = DateFormat('HH:mm').format(startDuration);
    final endHourString = DateFormat('HH:mm').format(endDuration);

    if (finalEvent.event?.eventTypeRaw != null) {
      switch (finalEvent.event?.getEventType()) {
        // Check event type
        case EventType.prepTimeEvent:
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: finalEvent.event?.subject?.colorHex != null
                  ? HexColor.fromHex(finalEvent.event!.subject!.colorHex!)
                  : Colors.red,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              margin: const EdgeInsetsDirectional.only(top: 2),
              decoration: BoxDecoration(
                  color: theme == ThemeMode.light
                      ? Colors.white
                      : Constants.darkThemeSecondaryBackgroundColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 2.0,
                      spreadRadius: 1.0,
                    ),
                  ]),
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Container(
                              margin: const EdgeInsets.only(
                                  top: 18, right: 15, left: 15),
                              child: Text(
                                finalEvent.event?.subject?.subjectName ?? "",
                                style: TextStyle(
                                    overflow: TextOverflow.visible,
                                    fontSize: 20,
                                    fontFamily: 'BebasNeue',
                                    fontWeight: FontWeight.normal,
                                    color:
                                        finalEvent.event?.subject?.colorHex !=
                                                null
                                            ? HexColor.fromHex(finalEvent
                                                .event!.subject!.colorHex!)
                                            : Colors.red),
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 22, right: 15),
                            child: Text(
                              "Prep",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.bold,
                                color: theme == ThemeMode.light
                                    ? Colors.black.withOpacity(0.4)
                                    : Colors.white.withOpacity(0.4),
                              ),
                            ),
                          )
                        ],
                      ),
                      Container(
                        margin: const EdgeInsets.only(left: 15, top: 8),
                        child: Text(
                          finalEvent.event?.eventTypeRaw ?? "",
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            color: theme == ThemeMode.light
                                ? Colors.black.withOpacity(0.4)
                                : Colors.white.withOpacity(0.4),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    alignment: Alignment.bottomLeft,
                    margin: const EdgeInsets.only(left: 15, top: 8, bottom: 18),
                    child: Text(
                      "${startHourString} - ${endHourString}",
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: theme == ThemeMode.light
                            ? Constants.lightThemeTextSelectionColor
                            : Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        case EventType.classEvent:
          return Container(
            decoration: BoxDecoration(
                color: theme == ThemeMode.light
                    ? Colors.white
                    : Constants.darkThemeSecondaryBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                  ),
                ]),
            margin: EdgeInsets.all(4),
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 22, left: 15, right: 15),
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: finalEvent.event?.subject?.colorHex != null
                                ? HexColor.fromHex(
                                    finalEvent.event!.subject!.colorHex!)
                                : Colors.red,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        Flexible(
                        //  fit: FlexFit.tight,
                          child: Container(
                            margin: const EdgeInsets.only(top: 18, right: 15),
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                finalEvent.event?.subject?.subjectName ?? "",
                                style: TextStyle(
                                    overflow: TextOverflow.visible,
                                    fontSize: 20,
                                    fontFamily: 'BebasNeue',
                                    fontWeight: FontWeight.normal,
                                    color: finalEvent.event?.subject?.colorHex !=
                                            null
                                        ? HexColor.fromHex(
                                            finalEvent.event!.subject!.colorHex!)
                                        : Colors.red),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 15, top: 8),
                      child: Text(
                        finalEvent.event?.eventTypeRaw ?? "",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(0.44)
                              : Colors.white.withOpacity(0.4),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(left: 15, top: 8, bottom: 18),
                  child: Text(
                    "${startHourString} - ${endHourString}",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: theme == ThemeMode.light
                          ? Constants.lightThemeTextSelectionColor
                          : Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        case EventType.examEvent:
          return Container(
            margin: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: theme == ThemeMode.light
                    ? Colors.white
                    : Constants.darkThemeSecondaryBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 2.0,
                    color: theme == ThemeMode.light
                        ? Constants.lightThemeTextSelectionColor
                        : Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                  ),
                ]),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 8, left: 15),
                  alignment: Alignment.topLeft,
                  child: Text(
                    "EXAM",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        color: theme == ThemeMode.light
                            ? Constants.lightThemeTextSelectionColor
                            : Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(left: 15, top: 8, bottom: 18),
                  child: Text(
                    "${startHourString} - ${endHourString}",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold,
                      color: theme == ThemeMode.light
                          ? Constants.lightThemeTextSelectionColor
                          : Colors.white,
                    ),
                  ),
                )
              ],
            ),
          );
        case EventType.taskDueEvent:
          return Container();

        case EventType.breakEvent:
          return Container();

        case EventType.eventsEvent:
          return Container(
            decoration: BoxDecoration(
                color: theme == ThemeMode.light
                    ? Colors.white
                    : Constants.darkThemeSecondaryBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                  ),
                ]),
            margin: EdgeInsets.all(4),
            child: Stack(
              children: [
                Container(
                  alignment: Alignment.topRight,
                  margin: EdgeInsets.only(right: 15),
                  child: Image.asset('assets/images/EventBlueIcon.png'),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Container(
                        alignment: Alignment.topLeft,
                        margin:
                            const EdgeInsets.only(top: 18, right: 15, left: 15),
                        child: Text(
                          finalEvent.event?.subject?.subjectName ?? "",
                          style: TextStyle(
                              overflow: TextOverflow.visible,
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: theme == ThemeMode.light
                                  ? Constants.lightThemeTextSelectionColor
                                  : Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomLeft,
                      margin:
                          const EdgeInsets.only(left: 15, top: 8, bottom: 18),
                      child: Text(
                        "${startHourString} - ${endHourString}",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          color: theme == ThemeMode.light
                              ? Constants.lightThemeTextSelectionColor
                              : Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        default:
          return Container();
      }
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final theme = ref.watch(themeModeProvider);

        return Container(
          color: Colors.transparent,
          margin: const EdgeInsets.only(top: 50, right: 20),
          child: Stack(
            children: [
              CustomTimelineDatePicker(
                daySelected: widget.daySelected,
                pageChanged: widget.pageChanged,
                selectedDay: widget.selectedDay,
              ),
              Container(
                color: Colors.transparent,
                margin: const EdgeInsets.only(top: 130, left: 20),
                child: DayView<Event>(
                  onEventTap: (events, date) {
                    var tappedevent = events.first;

                  //  print("EVENT ${tappedevent.event!.getEventType()}");

                    switch (tappedevent.event!.getEventType()) {
                      case EventType.classEvent:
                        _openClassDetails(tappedevent.event ?? Event());
                        break;
                        case EventType.examEvent:
                        _openExamDetails(tappedevent.event ?? Event());
                        break;
                      default:
                    }
                  },
                  verticalLineOffset: 40,
                  backgroundColor: Colors.transparent,
                  key: widget.state,
                  width: widget.width,
                  showLiveTimeLineInAllDays: false,
                  heightPerMinute: 1.9,
                  liveTimeIndicatorSettings: HourIndicatorSettings.none(),
                  dayTitleBuilder: (date) {
                    return Container();
                  },
                  showVerticalLine: false,
                  hourIndicatorSettings: HourIndicatorSettings.none(),
                  eventTileBuilder:
                      (date, events, boundary, startDuration, endDuration) {
                    return createEventTileContainer(
                        date, events, startDuration, endDuration, theme);
                  },
                  timeLineBuilder: (date) {
                    final hour = DateFormat('HH:mm').format(date);
                    return SizedBox(
                      height: 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            hour,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'Roboto',
                                fontWeight: FontWeight.normal,
                                color: Constants.dayCalendarHourColor),
                          ),
                          Container(
                            height: 2,
                          ),
                          Container(
                            height: 2,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Constants.dayCalendarLineColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Container(
                            height: 6,
                          ),
                          Container(
                            height: 2,
                            width: 20,
                            decoration: BoxDecoration(
                              color: Constants.dayCalendarLineColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          Container(
                            height: 6,
                          ),
                          Container(
                            height: 2,
                            width: 10,
                            decoration: BoxDecoration(
                              color: Constants.dayCalendarLineColor,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
