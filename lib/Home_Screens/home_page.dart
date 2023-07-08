import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Widgets/ClassWidgets/class_widget.dart';
import 'dart:convert';
import 'dart:math' as math;
import '../Models/Services/storage_service.dart';
import 'package:calendar_view/calendar_view.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import './search_page.dart';
import '../Extensions/extensions.dart';
import '../Widgets/home_tab_bar_card.dart';
import '../Models/home_tab_items.dart';
import '../Widgets/loaderIndicator.dart';
import '../Widgets/exam_widget.dart';
import '../Widgets/quotes_widget.dart';
import './class_details_screen.dart';
import '../login_state.dart';
import './exam_details_screen.dart';
import '../Widgets/TaskWidgets/task_widget.dart';
import '../Home_Screens/exam_details_screen.dart';
import '../Activities_Screens/task_detail_screen.dart';

import '../Models/API/result.dart';
import '../Widgets/custom_snack_bar.dart';
import '../Networking/sync_controller.dart';
import '../Models/API/classmodel.dart';
import '../Models/API/exam.dart';
import '../Models/API/task.dart';
import '../Models/user.model.dart';
import '../Models/API/event.dart';

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

class HomePage extends StatefulWidget {
  HomePage({super.key, required this.detailsPath});
  // final ValueChanged<int>? onPush;
  late ScrollController _controller;
  final String detailsPath;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime now = DateTime.now();
  final List<HomeTabItem> _homeTabItemsDataSource = HomeTabItem.tabItems;
  // final List<ClassStatic> _classes = ClassStatic.classes;
  //final List<ExamStatic> _exams = ExamStatic.exams;
  final StorageService _storageService = StorageService();
  String userName = "User";
  List<ClassModel> _classes = [];
  List<Exam> _exams = [];
  List<Task> _tasks = [];
  List<CalendarEventData<Event>> _events = [];
  int classesCount = 0;
  int examsCount = 0;
  int tasksCount = 0;
// CalendarControllerProvider<Event> eventPpovider = CalendarControllerProvider(controller: controller, child: child);
  int selectedTabIndex = 0;
  final SyncController _syncController = SyncController();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getUserName();
      syncData();
    });
  }

  void syncData() async {
    LoadingDialog.show(context);

    Result response = await _syncController.syncAll();

    if (!context.mounted) return;

    LoadingDialog.hide(context);

    if (response is ErrorState) {
      ErrorState error = response as ErrorState;

      CustomSnackBar.show(context, CustomSnackBarType.error, error.msg, true);
    }

    if (response is SuccessState) {
      // Get Classes from storage
      var classesData = await _storageService.readSecureData("user_classes");

      List<dynamic> decodedDataClasses = jsonDecode(classesData ?? "");

      // Get Exams from storage
      var examsData = await _storageService.readSecureData("user_exams");

      List<dynamic> decodedDataExams = jsonDecode(examsData ?? "");

      // Get Tasks from storage
      var tasksData = await _storageService.readSecureData("user_tasks");

      List<dynamic> decodedDataTasks = jsonDecode(tasksData ?? "");

      // Get Events from storage
      var eventsData = await _storageService.readSecureData("user_events");

      List<dynamic> decodedDataEvents = jsonDecode(eventsData ?? "");

      setState(() {
        _classes = List<ClassModel>.from(
          decodedDataClasses
              .map((x) => ClassModel.fromJson(x as Map<String, dynamic>)),
        );

        _homeTabItemsDataSource[0].badgeNumber = _classes.length;

        _exams = List<Exam>.from(
          decodedDataExams.map((x) => Exam.fromJson(x as Map<String, dynamic>)),
        );

        _homeTabItemsDataSource[1].badgeNumber = _exams.length;

        _tasks = List<Task>.from(
          decodedDataTasks.map((x) => Task.fromJson(x as Map<String, dynamic>)),
        );

        _homeTabItemsDataSource[2].badgeNumber = _tasks.length;

        var events = List<Event>.from(
          decodedDataEvents
              .map((x) => Event.fromJson(x as Map<String, dynamic>)),
        );

        for (var eventEntry in events) {

          var newCalendarEntry = CalendarEventData(
            date: eventEntry.getFormattedStartingDate(),
            event: eventEntry,
            title: eventEntry.mode ?? "",
            description: "Today is project meeting.",
            startTime: DateTime(
                eventEntry.getFormattedStartingDate().year,
                eventEntry.getFormattedStartingDate().month,
                eventEntry.getFormattedStartingDate().day,
                eventEntry.toTimeOfDay(eventEntry.startTime ?? "").hour,
                eventEntry.toTimeOfDay(eventEntry.startTime ?? "").minute),
            endTime: DateTime(
                eventEntry.getFormattedStartingDate().year,
                eventEntry.getFormattedStartingDate().month,
                eventEntry.getFormattedStartingDate().day,
                eventEntry.endTime != null
                    ? eventEntry.toTimeOfDay(eventEntry.endTime ?? "").hour
                    : eventEntry.toTimeOfDay(eventEntry.startTime ?? "").hour,
                eventEntry.endTime != null ? eventEntry.toTimeOfDay(eventEntry.endTime ?? "").minute : eventEntry.duration ?? 60),
          );

          // print("DATE START : ${newCalendarEntry.date}");
          // print("TIMEEE : ${newCalendarEntry.startTime}");
          // print("TIMEEE END: ${newCalendarEntry.endTime}");

          _events.add(newCalendarEntry);
        }

        CalendarControllerProvider.of<Event>(
                scaffoldMessengerKey.currentState!.context)
            .controller
            .addAll(_events);
      });
    }
  }

  String _getGreetingMessage() {
    String greeting = "";
    int hours = now.hour;

    if (hours >= 1 && hours <= 12) {
      greeting = "Good Morning";
    } else if (hours >= 12 && hours <= 16) {
      greeting = "Good Afternoon";
    } else if (hours >= 16 && hours <= 21) {
      greeting = "Good Evening";
    } else if (hours >= 21 && hours <= 24) {
      greeting = "Good Night";
    }

    return greeting;
  }

  void _getUserName() async {
    var userString = await _storageService.readSecureData("activeUser");
    if (userString != null && userString.isNotEmpty) {
      Map<String, dynamic> userMap = jsonDecode(userString);

      var user = UserModel.fromJson(userMap);
      setState(() {
        userName = user.firstName ?? "";
      });
    }
  }

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _homeTabItemsDataSource) {
        item.selected = false;
      }

      _homeTabItemsDataSource[index].selected = true;
    });
  }

  void _logOut(BuildContext context, WidgetRef ref) {
    ref.read(loginStateProvider).loggedIn = false;
    // context.beamToNamed('/login');
    //context.go(Constants.homeRouteName);
  }

  void _selectedCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ClassDetailsScreen(_classes[index]),
            fullscreenDialog: true));
  }

  void _selectedExamCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ExamDetailsScreen(examItem: _exams[index]),
            fullscreenDialog: true));
  }

  void _selectedTaskCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskDetailsScreen(_tasks[index]),
            fullscreenDialog: true));
  }

  // Sliver
  SliverPersistentHeader makeHeader(ThemeMode theme) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: _SliverAppBarDelegate(
        minHeight: 51.0,
        maxHeight: 51.0,
        child: Container(
          //color: Colors.white,
          color: theme == ThemeMode.light
              ? Constants.lightThemeBackgroundColor
              : Constants.darkThemeBackgroundColor,
          child: Stack(
            children: [
              Container(
                // Tab items
                height: 51,
                width: double.infinity,
                alignment: Alignment.topCenter,
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: _homeTabItemsDataSource
                      .mapIndexed((e, i) => TabBarCard(
                            title: e.title,
                            badgeNumber: e.badgeNumber,
                            selected: e.selected,
                            cardIndex: e.cardIndex,
                            cardselected: _selectTab,
                            isLightTheme: theme == ThemeMode.light,
                          ))
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
     // final sync = ref.watch(syncControllerProvider);

      return ScaffoldMessenger(
        child: Scaffold(
            backgroundColor: theme == ThemeMode.light
                ? Constants.lightThemeBackgroundColor
                : Constants.darkThemeBackgroundColor,
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.blue,
              elevation: 0.0,
              title: const Text(""),
              actions: [
                // Navigate to the Search Screen
                IconButton(
                  onPressed: () => _logOut(context, ref),
                  icon: theme == ThemeMode.light
                      ? Image.asset('assets/images/SearchIconLightTheme.png')
                      : Image.asset('assets/images/SearchIconDarkTheme.png'),
                ),
              ],
            ),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: RefreshIndicator(
                onRefresh: () async {
                  return syncData();
                },
                edgeOffset: 100,
                child: CustomScrollView(
                  //controller: widget.controller,
                  slivers: <Widget>[
                    SliverFixedExtentList(
                      itemExtent: 123.0,
                      delegate: SliverChildListDelegate(
                        [
                          Container(
                            height: 103,
                            child: Stack(
                              children: [
                                Container(
                                  // Greeting message
                                  height: 19,
                                  alignment: Alignment.topCenter,
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(
                                    _getGreetingMessage(),
                                    style: theme == ThemeMode.light
                                        ? Constants
                                            .lightThemeGreetingMessageStyle
                                        : Constants
                                            .darkThemeGreetingMessageStyle,
                                  ),
                                ),
                                Container(
                                  // User Name
                                  height: 42,
                                  alignment: Alignment.topCenter,
                                  margin: const EdgeInsets.only(top: 27),
                                  child: Text(
                                    userName,
                                    style: theme == ThemeMode.light
                                        ? Constants.lightThemeTitleTextStyle
                                        : Constants.darkThemeTitleTextStyle,
                                  ),
                                ),
                                Container(
                                  // Today's date
                                  height: 42,
                                  alignment: Alignment.topCenter,
                                  margin: const EdgeInsets.only(top: 72),
                                  child: Text(
                                    now.getFormattedDate(now),
                                    style: theme == ThemeMode.light
                                        ? Constants.lightThemeTodayDateTextStyle
                                        : Constants.darkThemeTodayDateTextStyle,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    makeHeader(theme),
                    if (selectedTabIndex == 0) ...[
                      SliverFixedExtentList(
                          itemExtent: 130,
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return ClassWidget(
                                classItem: _classes[index],
                                cardIndex: index,
                                upNext: true,
                                cardselected: _selectedCard);
                          }, childCount: _classes.length)),
                    ],
                    if (selectedTabIndex == 1) ...[
                      SliverFixedExtentList(
                          itemExtent: 145,
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return ExamWidget(
                                examItem: _exams[index],
                                cardIndex: index,
                                upNext: true,
                                cardselected: _selectedExamCard);
                          }, childCount: _exams.length)),
                    ],
                    if (selectedTabIndex == 2) ...[
                      SliverFixedExtentList(
                          itemExtent: 145,
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return TaskWidget(
                                taskItem: _tasks[index],
                                cardIndex: index,
                                upNext: false,
                                cardselected: _selectedTaskCard);
                            // return QuotesWidget(
                            //     quote:
                            //         "Wake up determined, Go to bed Satisfied",
                            //     cardIndex: index,
                            //     cardselected: _selectedCard);
                          }, childCount: _tasks.length)),
                    ],
                  ],
                ),
              ),
              // child: Stack(
              //   children: [
              //     // Container(
              //     //   // Greeting message
              //     //   height: 19,
              //     //   alignment: Alignment.topCenter,
              //     //   margin: const EdgeInsets.only(top: 5),
              //     //   child: Text(
              //     //     _getGreetingMessage(),
              //     //     style: theme == ThemeMode.light
              //     //         ? Constants.lightThemeGreetingMessageStyle
              //     //         : Constants.darkThemeGreetingMessageStyle,
              //     //   ),
              //     // ),
              //     // Container(
              //     //   // User Name
              //     //   height: 42,
              //     //   alignment: Alignment.topCenter,
              //     //   margin: const EdgeInsets.only(top: 27),
              //     //   child: Text(
              //     //     'UserName',
              //     //     style: theme == ThemeMode.light
              //     //         ? Constants.lightThemeTitleTextStyle
              //     //         : Constants.darkThemeTitleTextStyle,
              //     //   ),
              //     // ),
              //     // Container(
              //     //   // Today's date
              //     //   height: 42,
              //     //   alignment: Alignment.topCenter,
              //     //   margin: const EdgeInsets.only(top: 72),
              //     //   child: Text(
              //     //     now.getFormattedDate(now),
              //     //     style: theme == ThemeMode.light
              //     //         ? Constants.lightThemeTodayDateTextStyle
              //     //         : Constants.darkThemeTodayDateTextStyle,
              //     //   ),
              //     // ),
              //     // Container(
              //     //   // Tab items
              //     //   height: 51,
              //     //   width: double.infinity,
              //     //   alignment: Alignment.topCenter,
              //     //   margin:
              //     //       const EdgeInsets.only(top: 130, left: 20, right: 20),
              //     //   child: Row(
              //     //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //     //     crossAxisAlignment: CrossAxisAlignment.stretch,
              //     //     children: _homeTabItemsDataSource
              //     //         .mapIndexed((e, i) => TabBarCard(
              //     //               title: e.title,
              //     //               badgeNumber: e.badgeNumber,
              //     //               selected: e.selected,
              //     //               cardIndex: e.cardIndex,
              //     //               cardselected: _selectTab,
              //     //               isLightTheme: theme == ThemeMode.light,
              //     //             ))
              //     //         .toList(),
              //     //   ),
              //     // ),
              //     if (selectedTabIndex == 0) ...[
              //       // Classes
              //       Container(
              //         alignment: Alignment.topCenter,
              //         height: double.infinity,
              //         margin: const EdgeInsets.only(top: 186),
              //         child: ListView.builder(
              //             // controller: widget._controller,
              //             itemCount: _classes.length,
              //             itemBuilder: (context, index) {
              //               return ClassWidget(
              //                   classItem: _classes[index],
              //                   cardIndex: index,
              //                   upNext: true,
              //                   cardselected: _selectedCard);
              //             }),
              //       ),
              //     ],
              //     if (selectedTabIndex == 1) ...[
              //       // Exams
              //       Container(
              //         alignment: Alignment.topCenter,
              //         height: double.infinity,
              //         margin: const EdgeInsets.only(top: 186),
              //         child: ListView.builder(
              //             // controller: widget._controller,
              //             itemCount: _exams.length,
              //             itemBuilder: (context, index) {
              //               return ExamWidget(
              //                   classItem: _exams[index],
              //                   cardIndex: index,
              //                   upNext: true,
              //                   cardselected: _selectedExamCard);
              //             }),
              //       ),
              //     ],
              //     if (selectedTabIndex == 2) ...[
              //       // Tasks Due
              //       Container(
              //         alignment: Alignment.topCenter,
              //         height: double.infinity,
              //         margin: const EdgeInsets.only(top: 186),
              //         child: ListView.builder(
              //             // controller: widget._controller,
              //             itemCount: 1,
              //             itemBuilder: (context, index) {
              //               return QuotesWidget(
              //                   quote:
              //                       "Wake up determined, Go to bed Satisfied",
              //                   cardIndex: index,
              //                   cardselected: _selectedCard);
              //             }),
              //       ),
              //     ],
              //   ],
              // ),
            )),
      );
    });
  }
}
