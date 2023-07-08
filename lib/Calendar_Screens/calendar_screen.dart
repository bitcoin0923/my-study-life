import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:my_study_life_flutter/Models/API/exam.dart';
import '../Utilities/constants.dart';
import 'package:intl/intl.dart';
import 'package:calendar_view/calendar_view.dart';
import 'dart:convert';
import '../Models/Services/storage_service.dart';
import 'dart:math' as math;
import 'package:dio/dio.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/custom_snack_bar.dart';

import '../../app.dart';
import '../Activities_Screens/custom_segmentedcontrol.dart';
import '../Models/API/event.dart';
import '../Widgets/CalendarWidgets/day_view_widget.dart';
import '../Widgets/CalendarWidgets/month_view_widget.dart';
import '../Widgets/CalendarWidgets/week_view_widget.dart';
import '../Home_Screens/class_details_screen.dart';
import '../Widgets/ClassWidgets/class_widget.dart';
import '../Widgets/custom_centered_dialog.dart';
import '../Models/API/classmodel.dart';
import '../Models/API/event.dart';
import '../Widgets/exam_widget.dart';
import '../Home_Screens/exam_details_screen.dart';
import '../Models/API/task.dart';
import '../Networking/calendar_event_service.dart';

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  final double minHeight;
  final double maxHeight;
  final Widget child;

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => math.max(maxHeight, minHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}

class CalendarScreen extends StatefulWidget {
  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen>
    with WidgetsBindingObserver {
  // AppLifecycleState? _notification;
  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   setState(() {
  //     _notification = state;
  //     if (_notification?.index == 0) {
  //          var events = CalendarControllerProvider.of<Event>(
  //               scaffoldMessengerKey.currentState!.context)
  //           .controller.events;

  //           for (var event in events) {
  //             print("OJSAAAAA ${event.event?.module}");
  //           }
  //     }
  //   });
  // }

  int selectedTabIndex = 1;
  String currentMonthName = "";
  String currentWeekName = "";
  DateTime currentSelectedDate = DateTime.now();
  String currentSelectedDayStringName = "";
  final ValueNotifier<DateTime> currentSelectedDay =
      ValueNotifier(DateTime.now());

  List<Event> _events = [];
  final StorageService _storageService = StorageService();

  static GlobalKey<MonthViewState> stateKey = GlobalKey<MonthViewState>();
  final GlobalKey<DayViewState> dayStateKey = GlobalKey<DayViewState>();
  final GlobalKey<WeekViewState> weekStateKey = GlobalKey<WeekViewState>();

  @override
  void initState() {
    super.initState();
   // WidgetsBinding.instance.addObserver(this);
    currentMonthName = _getCurrentMonthName();
    currentWeekName = _getCurrentWeekName();
    currentSelectedDayStringName = _getCurrentDayName();
    Future.delayed(const Duration(seconds: 2), () {
      getData();
    });
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  void getData() async {
    var eventData = await _storageService.readSecureData("user_events");

    List<dynamic> decodedDataClasses = jsonDecode(eventData ?? "");

    setState(() {
      var allEvents = List<Event>.from(
        decodedDataClasses
            .map((x) => Event.fromJson(x as Map<String, dynamic>)),
      );

      _events = allEvents.where((e) {
        final mapDate = e.getFormattedStartingDate();

        return mapDate.isToday();
      }).toList();
      // for (var event in _events) {
      //   print("OVA LISTA OH ${event.getEventType()}");
      // }
    });
  }

  Future _getCalendarEventsForDate(DateTime date) async {
    //  DateTime dateTo = date.add(Duration(days: 1));

    String formattedDateFrom = DateFormat('yyyy/MM/dd').format(date);

    String formattedDateTo = DateFormat('yyyy/MM/dd').format(date);

    LoadingDialog.show(context);

    try {
      var calendarEventssResponse = await CalendarEventService()
          .getEvents(formattedDateFrom, formattedDateTo);

      if (!context.mounted) return;

      LoadingDialog.hide(context);

      final eventList = (calendarEventssResponse.data['events']) as List;
      _events = eventList.map((i) => Event.fromJson(i)).toList();

      // for (var eventItem in _events) {
      //   print("EVENt ${eventItem.getFormattedStartingDate()}");
      // }
    } catch (error) {
      if (error is DioError) {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            error.response?.data['message'], false);
      } else {
        LoadingDialog.hide(context);
        CustomSnackBar.show(context, CustomSnackBarType.error,
            "Oops, something went wrong", false);
      }
    }
  }

  // Sliver
  SliverPersistentHeader makeHeader(ThemeMode theme) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 281.0,
        maxHeight: 281.0,
        child: Container(
          //color: Colors.white,
          color: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 135, left: 20, right: 20),
                height: 281,
                padding: EdgeInsets.only(bottom: 10, left: 10, right: 4),
                decoration: BoxDecoration(
                  color: theme == ThemeMode.light
                      ? Colors.white
                      : Constants.darkThemeSecondaryBackgroundColor,
                  border: Border.all(
                    width: 0,
                    color: theme == ThemeMode.dark
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: theme == ThemeMode.light
                          ? Colors.black.withOpacity(.1)
                          : Colors.white.withOpacity(.1),
                      blurRadius: 15.0, // soften the shadow
                      spreadRadius: 5.0,
                      offset: Offset(
                        0.0,
                        2.0,
                      ),
                    ),
                  ],
                ),
                child: MonthViewWidget(
                  state: stateKey,
                  pageChanged: _calendarPageChanged,
                  daySelected: _calendarDaySelected,
                  currentSelectedDay: currentSelectedDay.value,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 430, left: 20),
                child: Text(currentSelectedDayStringName,
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeSubtitleTextStyle
                        : Constants.darkThemeTaskDueDescriptionTextStyle),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _selectedCard(int index) {
    var classModel = ClassModel(
        id: _events[index].id,
        module: _events[index].module,
        mode: _events[index].mode,
        room: _events[index].room,
        building: _events[index].building,
        onlineUrl: _events[index].onlineUrl,
        teacher: _events[index].teacher,
        teachersEmail: _events[index].teachersEmail,
        occurs: _events[index].occurs,
        days: _events[index].days,
        startDate: _events[index].startDate,
        endDate: _events[index].endDate,
        startTime: _events[index].startTime,
        endTime: _events[index].endTime,
        createdAt: _events[index].createdAt,
        subject: _events[index].subject);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClassDetailsScreen(classModel),
            fullscreenDialog: true));
  }

  void _selectedExamCard(int index) {
    var examItem = Exam(
        id: _events[index].id,
        resit: _events[index].resit,
        module: _events[index].module,
        mode: _events[index].mode,
        onlineUrl: _events[index].onlineUrl,
        room: _events[index].room,
        seat: _events[index].seat,
        startDate: _events[index].startDate,
        startTime: _events[index].startTime,
        duration: _events[index].duration,
        createdAt: _events[index].createdAt);

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExamDetailsScreen(examItem: examItem),
            fullscreenDialog: true));
  }

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

  void _selectedTabWithIndex(int index) {
    setState(() {
      selectedTabIndex = index;
    });
  }

  String _getCurrentMonthName() {
    final today = DateTime.now();

    final DateFormat monthFormat = DateFormat('MMMM');

    return monthFormat.format(today);
  }

  String _getCurrentWeekName() {
    final today = currentSelectedDate;
    final DateTime firstDayOfWeek = today.firstDayOfWeek();
    final endofWeekDate = firstDayOfWeek.add(Duration(days: 6));
    final DateFormat weekFormat = DateFormat('dd MMM, yyyy');

    return "${firstDayOfWeek.day} - ${weekFormat.format(endofWeekDate)}";
  }

  String _getCurrentDayName() {
    final today = DateTime.now();

    final DateFormat dayFormat = DateFormat('EEEEE, MMMM d yyyy');

    return dayFormat.format(today);
  }

  void _tappedLeftNavigationButton() {
    if (selectedTabIndex == 1) {
      dayStateKey.currentState?.animateToDate(currentSelectedDate);
    }
    if (selectedTabIndex == 2) {
      weekStateKey.currentState?.previousPage();
    }
    if (selectedTabIndex == 3) {
      stateKey.currentState?.previousPage();
    }

    currentSelectedDate =
        DateTime(currentSelectedDate.year, currentSelectedDate.month - 1, 1);

    setState(() {
      final DateFormat monthFormat = DateFormat('MMMM');
      currentSelectedDay.value = currentSelectedDate;
      currentWeekName = _getCurrentWeekName();
      currentMonthName = monthFormat.format(currentSelectedDay.value);
    });
  }

  void _tappedRightNavigationButton() {
    if (selectedTabIndex == 1) {
      dayStateKey.currentState?.animateToDate(currentSelectedDate);
    }
    if (selectedTabIndex == 2) {
      weekStateKey.currentState?.nextPage();
    }
    if (selectedTabIndex == 3) {
      stateKey.currentState?.nextPage();
    }

    currentSelectedDate =
        DateTime(currentSelectedDate.year, currentSelectedDate.month + 1, 1);

    setState(() {
      final DateFormat monthFormat = DateFormat('MMMM');
      currentSelectedDay.value = currentSelectedDate;
      currentWeekName = _getCurrentWeekName();
      currentMonthName = monthFormat.format(currentSelectedDay.value);
    });
    //dayStateKey.currentState?.
  }

  void _calendarPageChanged(DateTime date, int page) {
    final DateFormat monthFormat = DateFormat('MMMM');

    setState(() {
      currentSelectedDay.value = date;
      currentMonthName = monthFormat.format(date);
    });
  }

  void _calendarDaySelected(
      List<CalendarEventData<Event>> events, DateTime date) {
    final DateFormat dayFormat = DateFormat('EEEEE, MMMM d yyyy');

    setState(() {
      currentSelectedDay.value = date;
      currentSelectedDayStringName = dayFormat.format(date);
    });

    _getCalendarEventsForDate(date);
  }

  void _weekDayCalendarPageChanged(DateTime date) {
    final DateFormat monthFormat = DateFormat('MMMM');

    setState(() {
      currentSelectedDate = date;
      currentSelectedDay.value = date;
      currentMonthName = monthFormat.format(date);
      dayStateKey.currentState?.animateToDate(currentSelectedDate);
    });
  }

  void _weekDayCalendarDaySelected(DateTime date) {
    final DateFormat dayFormat = DateFormat('EEEEE, MMMM d yyyy');

    setState(() {
      currentSelectedDate = date;
      currentSelectedDay.value = date;
      dayStateKey.currentState?.animateToDate(date);
      //currentSelectedDayStringName = dayFormat.format(date);
    });
  }

  void _weekViewPageChanged(DateTime date, int page) {
    final endofWeekDate = date.add(Duration(days: 6));
    final DateFormat weekFormat = DateFormat('dd MMM, yyyy');

    setState(() {
      currentSelectedDate = date;
      currentSelectedDay.value = date;
      currentWeekName = "${date.day} - ${weekFormat.format(endofWeekDate)}";
      // dayStateKey.currentState?.animateToDate(currentSelectedDate);
    });
  }

  void _weekViewEventTapped(
      List<CalendarEventData<Event>> events, DateTime date) {
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
  }

  void _openLegend() {
    showCenteredPopup(context);
  }

  showCenteredPopup(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return CustomDialogBox();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 45),
          height: 125,
          width: 65,
          child: FloatingActionButton(
            heroTag: null,
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            highlightElevation: 0,
            onPressed: _openLegend,
            elevation: 0.0,
            child: Image.asset('assets/images/OpenLegendButtonIcon.png'),
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            "Schedule",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
          actions: [
            // Navigate to the Search Screen
            TextButton(
              onPressed: () {
                // Navigator.pop(context);
              },
              child: Text(
                'Today',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeNavigationButtonStyle
                    : Constants.darkThemeNavigationButtonStyle,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              height: 45,
              //width: double.infinity,
              margin: const EdgeInsets.only(left: 40, right: 40, top: 16),
              child: CustomSegmentedControl(
                _selectedTabWithIndex,
                tabs: {
                  1: Text(
                    'Days',
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeRegular14TextSelectedStyle
                        : Constants.darkThemeRegular14TextStyle,
                  ),
                  2: Text(
                    'Week',
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeRegular14TextSelectedStyle
                        : Constants.darkThemeRegular14TextStyle,
                  ),
                  3: Text(
                    'Month',
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeRegular14TextSelectedStyle
                        : Constants.darkThemeRegular14TextStyle,
                  ),
                },
              ),
            ),
            Container(
              height: 45,
              margin: const EdgeInsets.only(top: 80, left: 40, right: 40),
              decoration: BoxDecoration(
                color: theme == ThemeMode.light
                    ? Constants.lightThemeSecondaryColor
                    : Constants.darkThemeDividerColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: _tappedLeftNavigationButton,
                    icon: theme == ThemeMode.light
                        ? Image.asset('assets/images/ArrowLeftLightTheme.png')
                        : Image.asset('assets/images/ArrowLeftDarkTheme.png'),
                  ),
                  Container(
                    width: 40,
                  ),
                  Text(
                    selectedTabIndex != 2 ? currentMonthName : currentWeekName,
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeRegular14TextSelectedStyle
                        : Constants.darkThemeRegular14TextStyle,
                  ),
                  Container(
                    width: 40,
                  ),
                  IconButton(
                    onPressed: _tappedRightNavigationButton,
                    icon: theme == ThemeMode.light
                        ? Image.asset('assets/images/ArrowRightLightTheme.png')
                        : Image.asset('assets/images/ArrowRightDarkTheme.png'),
                  ),
                ],
              ),
            ),
            Container(
              height: 20,
            ),
            if (selectedTabIndex == 1) ...[
              Container(
                  margin: EdgeInsets.only(top: 75),
                  child: DayViewWidget(
                    state: dayStateKey,
                    daySelected: _weekDayCalendarDaySelected,
                    pageChanged: _weekDayCalendarPageChanged,
                    selectedDay: currentSelectedDay.value,
                  )),
            ],
            if (selectedTabIndex == 2) ...[
              Container(
                  margin: EdgeInsets.only(top: 135),
                  child: WeekViewWidget(
                    state: weekStateKey,
                    onPageChange: _weekViewPageChanged,
                    onEventTap: _weekViewEventTapped,
                  )),
            ],
            if (selectedTabIndex == 3) ...[
              Stack(
                children: [
                  Container(
                    margin:
                        const EdgeInsets.only(top: 135, left: 20, right: 20),
                    height: 281,
                    padding: EdgeInsets.only(bottom: 10, left: 10, right: 4),
                    decoration: BoxDecoration(
                      color: theme == ThemeMode.light
                          ? Colors.white
                          : Constants.darkThemeSecondaryBackgroundColor,
                      border: Border.all(
                        width: 0,
                        color: theme == ThemeMode.dark
                            ? Colors.white
                            : Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: theme == ThemeMode.light
                              ? Colors.black.withOpacity(.1)
                              : Colors.white.withOpacity(.1),
                          blurRadius: 15.0, // soften the shadow
                          spreadRadius: 5.0,
                          offset: Offset(
                            0.0,
                            2.0,
                          ),
                        ),
                      ],
                    ),
                    child: MonthViewWidget(
                      state: stateKey,
                      pageChanged: _calendarPageChanged,
                      daySelected: _calendarDaySelected,
                      currentSelectedDay: currentSelectedDay.value,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 430, left: 20),
                    child: Text(currentSelectedDayStringName,
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeTaskDueDescriptionTextStyle),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    height: double.infinity,
                    margin: const EdgeInsets.only(top: 450),
                    child: ListView.builder(
                        // controller: widget._controller,
                        itemCount: _events.length,
                        itemBuilder: (context, index) {
                          switch (_events[index].getEventType()) {
                            case EventType.classEvent:
                              return ClassWidget(
                                  eventItem: _events[index],
                                  cardIndex: index,
                                  upNext: true,
                                  cardselected: _selectedCard);
                            case EventType.examEvent:
                              return ExamWidget(
                                  eventItem: _events[index],
                                  cardIndex: index,
                                  upNext: true,
                                  cardselected: _selectedExamCard);
                            default:
                          }
                        }),
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }
}
