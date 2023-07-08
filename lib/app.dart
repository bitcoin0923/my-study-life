import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:calendar_view/calendar_view.dart';

import './bottom_navigation.dart';
import './tab_item.dart';
import 'main.dart';
import 'Home_Screens/create_screen.dart';
import './Utilities/constants.dart';
import './Home_Screens/home_page.dart';
import 'Home_Screens/create_screen.dart';
import './Home_Screens/class_details_screen.dart';
import './Controllers/auth_controller.dart';
import './Router/routes.dart';
import './Controllers/auth_notifier.dart';
import './Onboarding_Screens/forgot_password.dart';
import './Widgets/custom_snack_bar.dart';
import './Services/navigation_service.dart';
import 'Models/API/event.dart';
import '../Models/API/result.dart';

import './Networking/sync_controller.dart';

final themeModeProvider = StateProvider<ThemeMode>((ref) {
  var brightness = WidgetsBinding.instance.window.platformBrightness;

  if (brightness == Brightness.dark) {
    return ThemeMode.dark;
  } else {
    return ThemeMode.light;
  }
});

DateTime get _now => DateTime.now();

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

class App extends ConsumerStatefulWidget {
  App({super.key});

  @override
  ConsumerState<App> createState() => AppState();
}

class AppState extends ConsumerState<App>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final _routerDelegate;
  final eventController = EventController<Event>();
  @override
  void initState() {
    super.initState();
    _routerDelegate = BeamerDelegate(
      guards: [
        /// if the user is authenticated
        /// else send them to /login
        BeamGuard(
            pathPatterns: ['/home'],
            check: (context, state) {
              final container =
                  ProviderScope.containerOf(context, listen: false);
              return container.read(authProvider).status ==
                  AuthStatus.authenticated;
            },
            beamToNamed: (_, __) => '/started'),

        BeamGuard(
            pathPatterns: ['/profile'],
            check: (context, state) {
              final container =
                  ProviderScope.containerOf(context, listen: false);
              return container.read(authProvider).status ==
                  AuthStatus.authenticated;
            },
            beamToNamed: (_, __) => '/started'),

        /// if the user is anything other than authenticated
        /// else send them to /home
        BeamGuard(
            pathPatterns: ['/started'],
            check: (context, state) {
              final container =
                  ProviderScope.containerOf(context, listen: false);
              return container.read(authProvider).status !=
                  AuthStatus.authenticated;
            },
            beamToNamed: (_, __) => '/home'),
      ],
      initialPath: '/started',
      locationBuilder: (routeInformation, _) =>
          BeamerLocations(routeInformation),
    );
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    //  controller.dispose();
    super.dispose();
    // _controller.dispose();
  }

  @override
  void didChangePlatformBrightness() {
    final Brightness brightness =
        WidgetsBinding.instance.window.platformBrightness;
    //inform listeners and rebuild widget tree

    if (brightness == Brightness.dark) {
      ref.read(themeModeProvider.notifier).state = ThemeMode.dark;
    } else {
      ref.read(themeModeProvider.notifier).state = ThemeMode.light;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeModeProvider);

    final signInState = ref.watch(authProvider);
   // print("object ${signInState.status}");

    return BeamerProvider(
      routerDelegate: _routerDelegate,
      child: CalendarControllerProvider<Event>(
        controller: eventController,
        child: MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: Constants.kToLight, brightness: Brightness.light),
          darkTheme: ThemeData(
              primarySwatch: Constants.kToDark, brightness: Brightness.dark),
          themeMode: theme,
          routeInformationParser: BeamerParser(),
          routerDelegate: _routerDelegate,
          backButtonDispatcher: BeamerBackButtonDispatcher(
            delegate: _routerDelegate,
          ),
        ),
      ),
    );
  }
}

////final List<CalendarEventData<Event>> _events = [
  // CalendarEventData(
  //   date: _now,
  //   event: Event(title: "CHEMISTRY", eventType: EventType.breakEvent),
  //   title: "Project meeting",
  //   description: "Today is project meeting.",
  //   startTime: DateTime(_now.year, _now.month, _now.day, 18, 30),
  //   endTime: DateTime(_now.year, _now.month, _now.day, 22),
  // ),
  // CalendarEventData(
  //   date: _now.add(Duration(days: 1)),
  //   startTime: DateTime(_now.year, _now.month, _now.day, 18),
  //   endTime: DateTime(_now.year, _now.month, _now.day, 19),
  //   event: Event(title: "CHEMISTRY", eventType: EventType.prepTimeEvent),
  //   title: "Wedding anniversary",
  //   description: "Attend uncle's wedding anniversary.",
  // ),
  // CalendarEventData(
  //   date: _now,
  //   startTime: DateTime(_now.year, _now.month, _now.day, 00),
  //   endTime: DateTime(_now.year, _now.month, _now.day, 02),
  //   event: Event(title: "CHEMISTRY", eventType: EventType.prepTimeEvent),
  //   title: "Football Tournament",
  //   description: "Go to football tournament.",
  // ),
  // CalendarEventData(
  //   date: _now,
  //   startTime: DateTime(_now.year, _now.month, _now.day, 03),
  //   endTime: DateTime(_now.year, _now.month, _now.day, 05),
  //   event: Event(title: "BIOLOGY", eventType: EventType.classEvent),
  //   title: "Football2 Tournament",
  //   description: "Go to football2 tournament.",
  // ),
  // CalendarEventData(
  //   date: _now,
  //   startTime: DateTime(_now.year, _now.month, _now.day, 07),
  //   endTime: DateTime(_now.year, _now.month, _now.day, 08, 30),
  //   event: Event(title: "BIOLOGY", eventType: EventType.examEvent),
  //   title: "Football2 Tournament",
  //   description: "Go to football2 tournament.",
  // ),
  // CalendarEventData(
  //   date: _now,
  //   startTime: DateTime(_now.year, _now.month, _now.day, 12),
  //   endTime: DateTime(_now.year, _now.month, _now.day, 12, 15),
  //   event: Event(title: "BIOLOGY", eventType: EventType.taskDueEvent),
  //   title: "Football2 Tournament",
  //   description: "Go to football2 tournament.",
  // ),
  // CalendarEventData(
  //   date: _now.add(Duration(days: 6)),
  //   startTime: DateTime(_now.add(Duration(days: 6)).year,
  //       _now.add(Duration(days: 6)).month, _now.add(Duration(days: 6)).day, 10),
  //   endTime: DateTime(_now.add(Duration(days: 6)).year,
  //       _now.add(Duration(days: 6)).month, _now.add(Duration(days: 6)).day, 12),
  //   event: Event(title: "CHEMISTRY", eventType: EventType.eventsEvent),
  //   title: "Sprint Meeting.",
  //   description: "Last day of project submission for last year.",
  // ),
  // CalendarEventData(
  //   date: _now.subtract(Duration(days: 2)),
  //   startTime: DateTime(
  //       _now.subtract(Duration(days: 2)).year,
  //       _now.subtract(Duration(days: 2)).month,
  //       _now.subtract(Duration(days: 2)).day,
  //       14),
  //   endTime: DateTime(
  //       _now.subtract(Duration(days: 2)).year,
  //       _now.subtract(Duration(days: 2)).month,
  //       _now.subtract(Duration(days: 2)).day,
  //       16),
  //   event: Event(title: "CHEMISTRY", eventType: EventType.classEvent),
  //   title: "Team Meeting",
  //   description: "Team Meeting",
  // ),
  // CalendarEventData(
  //   date: _now.subtract(Duration(days: 2)),
  //   startTime: DateTime(
  //       _now.subtract(Duration(days: 2)).year,
  //       _now.subtract(Duration(days: 2)).month,
  //       _now.subtract(Duration(days: 2)).day,
  //       10),
  //   endTime: DateTime(
  //       _now.subtract(Duration(days: 2)).year,
  //       _now.subtract(Duration(days: 2)).month,
  //       _now.subtract(Duration(days: 2)).day,
  //       12),
  //   event: Event(title: "CHEMISTRY", eventType: EventType.classEvent),
  //   title: "Chemistry Viva",
  //   description: "Today is Joe's birthday.",
  // ),
//];
