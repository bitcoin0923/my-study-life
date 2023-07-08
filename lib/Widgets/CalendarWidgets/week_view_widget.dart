import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Models/API/event.dart';
import '../../Utilities/constants.dart';
import '../custom_painter_class.dart';

class WeekViewWidget extends StatefulWidget {
  final GlobalKey<WeekViewState>? state;
  final double? width;
  final Function onPageChange;
  final Function onEventTap;

  const WeekViewWidget(
      {Key? key,
      this.state,
      this.width,
      required this.onPageChange,
      required this.onEventTap})
      : super(key: key);

  @override
  State<WeekViewWidget> createState() => _WeekViewWidgetState();
}

class _WeekViewWidgetState extends State<WeekViewWidget> {
// Event tile creation
  Container createEventTileContainer(
      DateTime date,
      List<CalendarEventData<Event>> events,
      DateTime startDuration,
      DateTime endDuration,
      ThemeMode theme) {
    final CalendarEventData<Event> finalEvent =
        events.firstWhere((element) => element.startTime == startDuration);

    if (finalEvent.event?.eventTypeRaw != null) {
      switch (finalEvent.event?.getEventType()) {
        case EventType.prepTimeEvent:
          return Container(
            decoration: BoxDecoration(
                color: Colors.red, borderRadius: BorderRadius.circular(10)),
            child: Container(
              margin: const EdgeInsetsDirectional.only(top: 4),
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
                  Container(
                    alignment: Alignment.topCenter,
                    margin: const EdgeInsets.only(top: 6),
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
                  ),
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
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 5, left: 5, right: 15),
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
              ],
            ),
          );

        case EventType.examEvent:
          return Container(
            decoration: BoxDecoration(
                color: theme == ThemeMode.light
                    ? Colors.white
                    : Constants.darkThemeSecondaryBackgroundColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 2.0, color: Colors.red),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                  ),
                ]),
            child: Container(
              margin: const EdgeInsets.only(top: 8),
              alignment: Alignment.topCenter,
              child: Text(
                "EXAM",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          );

        case EventType.taskDueEvent:
          return Container(
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: const Text(
              "Due",
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          );

        case EventType.breakEvent:
          return Container(
            color: Colors.transparent,
            child: ClipRect(
              child: Container(
                color: Colors.transparent,
                child: StripsWidget(
                  color1: Constants.diagonalColorPainter,
                  color2: theme == ThemeMode.light
                      ? Constants.lightThemeBackgroundColor
                      : Constants.darkThemeBackgroundColor,
                  gap: 8,
                  noOfStrips: 100,
                ),
              ),
            ),
          );

        case EventType.eventsEvent:
          return Container(
            alignment: Alignment.topCenter,
            decoration: BoxDecoration(
              color: theme == ThemeMode.light
                  ? Colors.white
                  : Constants.darkThemeSecondaryBackgroundColor,
              borderRadius: BorderRadius.circular(10),
              // border: Border.all(color: Colors.grey),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 2.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Image.asset('assets/images/EventBlueIcon.png'),
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
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return WeekView<Event>(
        key: widget.state,
        backgroundColor: Colors.transparent,
        width: widget.width,
        heightPerMinute: 1.9,
        liveTimeIndicatorSettings: HourIndicatorSettings.none(),
        eventTileBuilder: (date, events, boundary, startDuration, endDuration) {
          return createEventTileContainer(
              date, events, startDuration, endDuration, theme);
        },
        weekPageHeaderBuilder: (startDate, endDate) {
          return Container();
        },
        weekDayBuilder: (date) {
          final weekDay = DateFormat('EEE').format(date);

          return Container(
            child: Center(
              child: Text(
                weekDay,
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: Constants.dayCalendarHourColor),
              ),
            ),
          );
        },
        weekNumberBuilder: (firstDayOfWeek) {
          return Container();
        },
        timeLineBuilder: (date) {
          final hour = DateFormat('HH:mm').format(date);
          return Container(
            color: theme == ThemeMode.light
                ? Colors.white
                : Constants.weekCalendarNormalDayDarkBackround,
            alignment: Alignment.topCenter,
            height: 100,
            child: Text(
              hour,
              style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                  color: Constants.dayCalendarHourColor),
            ),
          );
        },
        weekDetectorBuilder: (
            {required date,
            required height,
            required heightPerMinute,
            required minuteSlotSize,
            required width}) {
          final weekday = date.weekday;

          Color backgroundColor;

          switch (weekday) {
            case 1:
            case 3:
            case 5:
            case 7:
              backgroundColor = theme == ThemeMode.light
                  ? Constants.weekCalendarOddDayLightBackround
                  : Constants.weekCalendarOddDayDarkBackround;
              break;
            case 2:
            case 4:
            case 6:
              backgroundColor = theme == ThemeMode.light
                  ? Constants.weekCalendarNormalDayLightBackround
                  : Constants.weekCalendarNormalDayDarkBackround;
              break;
            default:
              backgroundColor = Colors.transparent;
          }

          return Container(color: backgroundColor);
        },
        onPageChange: (date, page) {
          widget.onPageChange(date, page);
        },
        onEventTap: (events, date) {
          widget.onEventTap (events, date);
        },
      );
    });
  }
}
