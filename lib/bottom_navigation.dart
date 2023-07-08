import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:beamer/beamer.dart';
import 'package:my_study_life_flutter/Home_Screens/class_details_screen.dart';
import 'package:my_study_life_flutter/Home_Screens/home_page.dart';
import 'package:my_study_life_flutter/Onboarding_Screens/login.dart';

import './tab_item.dart';
import 'main.dart';
import 'app.dart';
import './Utilities/constants.dart';
import 'Home_Screens/create_screen.dart';
import './Onboarding_Screens/get_started.dart';
import './Onboarding_Screens/login.dart';
import './Onboarding_Screens/forgot_password.dart';
import './Onboarding_Screens/signup.dart';
import './Activities_Screens/activities_screen.dart';
import './Profile_Screens/profile_screen.dart';
import './Calendar_Screens/calendar_screen.dart';
import './Home_Screens/empty_screen.dart';

class BeamerLocations extends BeamLocation<BeamState> {
  BeamerLocations(RouteInformation routeInformation) : super(routeInformation);

  @override
  List<Pattern> get pathPatterns => [
        'started',
        'profile'
      ];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) {
    return [
      if (state.uri.pathSegments.contains('started'))
        const BeamPage(
          key: ValueKey('started'),
          title: 'Get Started',
          child: GetStarted(),
        ),
      if (state.uri.pathSegments.contains('login'))
        BeamPage(
          key: const ValueKey('login'),
          title: 'Login',
          child: LoginScreen(),
        ),
      if (state.uri.pathSegments.contains('signup'))
        BeamPage(
          key: const ValueKey('signup'),
          title: 'Signup',
          child: RegisterScreen(),
        ),
      if (state.uri.pathSegments.contains('forgot_password'))
        BeamPage(
          key: const ValueKey('forgot_password'),
          title: 'Forgot Password',
          child: ForgotPasswordScreen(),
        ),
      if (state.uri.pathSegments.contains('home') || state.uri.pathSegments.contains('activities') || state.uri.pathSegments.contains('profile') || state.uri.pathSegments.contains('calendar') )
        const BeamPage(
          key: ValueKey('home2'),
          title: 'Home2',
          child: ScaffoldWithBottomNavBar(),
        ),
      // if (state.uri.pathSegments.contains('activities'))
      //   BeamPage(
      //     key: ValueKey('activities'),
      //     title: 'Tab Activities',
      //     child: ScaffoldWithBottomNavBar(),
      //   ),
      //     if (state.uri.pathSegments.contains('profile'))
      //   BeamPage(
      //     key: ValueKey('profile'),
      //     title: 'Tab Profile',
      //     child: ScaffoldWithBottomNavBar(),
      //   ),
    ];
  }
}

/// Location defining the pages for the first tab
class HomeTabItemLocation extends BeamLocation<BeamState> {
  HomeTabItemLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/home/:class-details'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        BeamPage(
          key: const ValueKey('home'),
          title: 'Tab Home',
          type: BeamPageType.noTransition,
          child: HomePage(detailsPath: 'home/details'),
        ),
        //  const BeamPage(
        //       key: ValueKey('/home/details'),
        //       title: 'Details A',
        //       child: ClassDetailsScreen(),
        //     ),
      ];
}

/// Location defining the pages for the second tab
class CalendarTabItemLocation extends BeamLocation<BeamState> {
  CalendarTabItemLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/calendar/:class-details'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('calendar'),
          title: 'Tab Calendar',
          type: BeamPageType.noTransition,
          child: CalendarScreen(),
        ),
        //  const BeamPage(
        //       key: ValueKey('/calendar/details'),
        //       title: 'Details A',
        //       child: ClassDetailsScreen(),
        //     ),
      ];
}

class EmptyTabTabItemLocation extends BeamLocation<BeamState> {
  EmptyTabTabItemLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/empty-tab/:class-details'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('empty-tab'),
          title: 'Tab empty-tab',
          type: BeamPageType.noTransition,
          child: EmptyScreen(),
        ),
        //  const BeamPage(
        //       key: ValueKey('/activities/details'),
        //       title: 'Details A',
        //       child: ClassDetailsScreen(),
        //     ),
      ];
}

/// Location defining the pages for the third tab
class ActivitiesTabItemLocation extends BeamLocation<BeamState> {
  ActivitiesTabItemLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/activities/:class-details'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('activities'),
          title: 'Tab Activities',
          type: BeamPageType.noTransition,
          child: ActivitiesScreen(),
        ),
        //  const BeamPage(
        //       key: ValueKey('/activities/details'),
        //       title: 'Details A',
        //       child: ClassDetailsScreen(),
        //     ),
      ];
}

/// Location defining the pages for the fourth tab
class ProfileTabItemLocation extends BeamLocation<BeamState> {
  ProfileTabItemLocation(super.routeInformation);
  @override
  List<String> get pathPatterns => ['/profile/:details'];

  @override
  List<BeamPage> buildPages(BuildContext context, BeamState state) => [
        const BeamPage(
          key: ValueKey('profile'),
          title: 'Tab Profile',
          type: BeamPageType.noTransition,
          child: ProfileScreen(),
        ),
        //  const BeamPage(
        //       key: ValueKey('/profile/details'),
        //       title: 'Details A',
        //       child: ClassDetailsScreen(),
        //     ),
      ];
}

/// Representation of a tab item in a [ScaffoldWithNavBar]
class ScaffoldWithNavBarTabItem extends BottomNavigationBarItem {
  /// Constructs an [ScaffoldWithNavBarTabItem].
  const ScaffoldWithNavBarTabItem(
      {required this.initialLocation,
      required Widget icon,
      required Widget activeIcon,
      String? label})
      : super(icon: icon, label: label, activeIcon: activeIcon);

  /// The initial location/path
  final String initialLocation;
}

class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({super.key});

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
   int _currentIndex = 0;

  final _routerDelegates = [
    BeamerDelegate(
      initialPath: '/home',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('home')) {
          return HomeTabItemLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/calendar',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('calendar')) {
          return CalendarTabItemLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/empty-tab',
      locationBuilder: (routeInformation, _) {
       if (routeInformation.location!.contains('asd')) {
          return EmptyTabTabItemLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/activities',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('activities')) {
          return ActivitiesTabItemLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
    BeamerDelegate(
      initialPath: '/profile',
      locationBuilder: (routeInformation, _) {
        if (routeInformation.location!.contains('profile')) {
          return ProfileTabItemLocation(routeInformation);
        }
        return NotFound(path: routeInformation.location!);
      },
    ),
  ];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final uriString = Beamer.of(context).configuration.location!;
    if (uriString.contains('home')) {
      _currentIndex = 0;
    }
    else  if (uriString.contains('calendar')) {
      _currentIndex = 1;
    }
    else   if (uriString.contains('activities')) {
      _currentIndex = 3;
    }
    else   if (uriString.contains('profile')) {
      _currentIndex = 4;
    }
    else {
      _currentIndex = 0;
    }
   /// _currentIndex = uriString.contains('home') ? 0 : 1;
  }

  bottomSheetForSignIn(BuildContext context) {
    showModalBottomSheet(
      
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        context: context,
        // transitionAnimationController: controller,
        enableDrag: false,
        builder: (context) {
          return const CreateScreen();
        });
  }

  void _openCreateScreen() {
    bottomSheetForSignIn(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      final tabs = [
        ScaffoldWithNavBarTabItem(
          initialLocation: '/a',
          icon: theme == ThemeMode.light
              ? TabItem.tabItems[0].icon
              : TabItem.tabItems[0].iconDark,
          activeIcon: theme == ThemeMode.light
              ? TabItem.tabItems[0].activeIcon
              : TabItem.tabItems[0].activeDarkIcon,
          label: TabItem.tabItems[0].name,
        ),
        ScaffoldWithNavBarTabItem(
          initialLocation: '/b',
          icon: theme == ThemeMode.light
              ? TabItem.tabItems[1].icon
              : TabItem.tabItems[1].iconDark,
          activeIcon: theme == ThemeMode.light
              ? TabItem.tabItems[1].activeIcon
              : TabItem.tabItems[1].activeDarkIcon,
          label: TabItem.tabItems[1].name,
        ),
        ScaffoldWithNavBarTabItem(
          initialLocation: '/c',
          icon: theme == ThemeMode.light
              ? TabItem.tabItems[2].icon
              : TabItem.tabItems[2].iconDark,
          activeIcon: theme == ThemeMode.light
              ? TabItem.tabItems[2].activeIcon
              : TabItem.tabItems[2].activeDarkIcon,
          label: TabItem.tabItems[2].name,
        ),
        ScaffoldWithNavBarTabItem(
          initialLocation: '/d',
          icon: theme == ThemeMode.light
              ? TabItem.tabItems[3].icon
              : TabItem.tabItems[3].iconDark,
          activeIcon: theme == ThemeMode.light
              ? TabItem.tabItems[3].activeIcon
              : TabItem.tabItems[3].activeDarkIcon,
          label: TabItem.tabItems[3].name,
        ),
        ScaffoldWithNavBarTabItem(
          initialLocation: '/e',
          icon: theme == ThemeMode.light
              ? TabItem.tabItems[4].icon
              : TabItem.tabItems[4].iconDark,
          activeIcon: theme == ThemeMode.light
              ? TabItem.tabItems[4].activeIcon
              : TabItem.tabItems[4].activeDarkIcon,
          label: TabItem.tabItems[4].name,
        ),
      ];

      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            Beamer(
              routerDelegate: _routerDelegates[0],
            ),
            Beamer(
              routerDelegate: _routerDelegates[1],
            ),
            Beamer(
              routerDelegate: _routerDelegates[2],
            ),
            Beamer(
              routerDelegate: _routerDelegates[3],
            ),
            Beamer(
              routerDelegate: _routerDelegates[4],
            ),
          ],
        ),
        floatingActionButton: Container(
          padding: const EdgeInsets.only(top: 45),
          height: 125,
          width: 65,
          child: FloatingActionButton(
            heroTag: "Create",
            foregroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            highlightElevation: 0,
            onPressed: _openCreateScreen,
            elevation: 0.0,
            child: Image.asset('assets/images/AddButtonIcon.png'),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          unselectedLabelStyle: const TextStyle(
              height: 2.0,
              //color: Colors.black,
              fontFamily: "Roboto",
              fontSize: 11,
              fontWeight: FontWeight.w400),
          selectedLabelStyle: const TextStyle(
              height: 2.0,
              //  color: Colors.black,
              fontFamily: "Roboto",
              fontSize: 11,
              fontWeight: FontWeight.w400),
          selectedItemColor: theme == ThemeMode.dark
              ? Constants.darkThemeTextSelectionColor
              : Constants.lightThemeTextSelectionColor,
          unselectedItemColor: theme == ThemeMode.dark
              ? Constants.darkThemeUnselectedTextColor
              : Constants.lightThemeUnselectedTextColor,
          backgroundColor: theme == ThemeMode.dark
              ? Constants.darkThemeNavigationBarColor
              : Colors.white,
          currentIndex: _currentIndex,
          items: tabs,
          onTap: (index) {
            if (index != _currentIndex) {
              setState(() => _currentIndex = index);
              _routerDelegates[_currentIndex].update(rebuild: false);
            }
          },
        ),
      );
    });
  }
}
