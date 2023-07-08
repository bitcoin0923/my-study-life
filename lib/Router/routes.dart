// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// import '../Home_Screens/home_page.dart';
// import '../Home_Screens/create_screen.dart';
// import '../Home_Screens/class_details_screen.dart';
// import '../Home_Screens/search_page.dart';
// import '../Onboarding_Screens/forgot_password.dart';
// import '../Onboarding_Screens/get_started.dart';
// import '../Onboarding_Screens/login.dart';
// import '../Onboarding_Screens/signup.dart';
// import '../login_state.dart';
// import '../Utilities/constants.dart';
// import '../Controllers/auth_controller.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import '../bottom_navigation.dart';

// class MyRouter {
//   final LoginState loginState;
//   final BuildContext context;
//   final List<ScaffoldWithNavBarTabItem> tabs;
//   final ThemeMode theme;
//   MyRouter(this.loginState, this.context, this.tabs, this.theme);

//   late final router = GoRouter(
//     refreshListenable: loginState,
//     debugLogDiagnostics: true,
//     initialLocation: '/',
//     // urlPathStrategy: UrlPathStrategy.path,
//     routes: [
//       ShellRoute(
//          // navigatorKey: _shellNavigatorKey,
//           builder: (context, state, child) {
//             return ScaffoldWithBottomNavBar(tabs: tabs, theme: theme,
//             child: child);
//           },
//           routes: [
//             // Home
//             GoRoute(
//               path: '/a',
//               pageBuilder: (context, state) => NoTransitionPage(
//                   key: state.pageKey,
//                   child: HomePage(
//                     detailsPath: '/a/classDetails',
//                   )),
//               routes: [
//                 GoRoute(
//                   path: 'classDetails',
//                   builder: (context, state) => const ClassDetailsScreen(),
//                 ),
//               ],
//             ),
//             // Calendar
//             GoRoute(
//               path: '/b',
//               pageBuilder: (context, state) => NoTransitionPage(
//                   key: state.pageKey,
//                   child: HomePage(
//                     detailsPath: '/b/classDetails',
//                   )),
//               routes: [
//                 GoRoute(
//                   path: 'classDetails',
//                   builder: (context, state) => const ClassDetailsScreen(),
//                 ),
//               ],
//             ),
//             GoRoute(
//               path: '/c',
//               pageBuilder: (context, state) => NoTransitionPage(
//                   key: state.pageKey,
//                   child: HomePage(
//                     detailsPath: '/c/classDetails',
//                   )),
//               routes: [
//                 GoRoute(
//                   path: 'classDetails',
//                   builder: (context, state) => const ClassDetailsScreen(),
//                 ),
//               ],
//             ),
//             GoRoute(
//               path: '/d',
//               pageBuilder: (context, state) => NoTransitionPage(
//                   key: state.pageKey,
//                   child: HomePage(
//                     detailsPath: '/d/classDetails',
//                   )
//                   // child: const RootScreen(label: 'A', detailsPath: '/a/details'),
//                   ),
//               routes: [
//                 GoRoute(
//                   path: 'classDetails',
//                   builder: (context, state) => const ClassDetailsScreen(),
//                 ),
//               ],
//             ),
//               GoRoute(
//               path: '/e',
//               pageBuilder: (context, state) => NoTransitionPage(
//                   key: state.pageKey,
//                   child: HomePage(
//                     detailsPath: '/e/classDetails',
//                   )
//                   // child: const RootScreen(label: 'A', detailsPath: '/a/details'),
//                   ),
//               routes: [
//                 GoRoute(
//                   path: 'classDetails',
//                   builder: (context, state) => const ClassDetailsScreen(),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       GoRoute(
//           name: Constants.rootRouteName,
//           path: '/',
//           redirect: (context, state) =>
//               GoRouter.of(context).namedLocation(Constants.homeRouteName)),
//       GoRoute(
//         name: Constants.loginRouteName,
//         path: '/login',
//         pageBuilder: (context, state) => MaterialPage<void>(
//           key: state.pageKey,
//           child: LoginScreen(),
//         ),
//       ),
//       GoRoute(
//         name: Constants.registerRouteName,
//         path: '/register',
//         pageBuilder: (context, state) => MaterialPage<void>(
//           key: state.pageKey,
//           child: RegisterScreen(),
//         ),
//       ),
//       GoRoute(
//         name: Constants.forgotPasswordRouteName,
//         path: '/forgotPasswordRouteName',
//         pageBuilder: (context, state) => MaterialPage<void>(
//           key: state.pageKey,
//           child: ForgotPasswordScreen(),
//         ),
//       ),
//       GoRoute(
//         name: Constants.getStartedRouteName,
//         path: '/getStartedRouteName',
//         pageBuilder: (context, state) => MaterialPage<void>(
//           key: state.pageKey,
//           child: const GetStarted(),
//         ),
//       ),

//       GoRoute(
//         name: Constants.homeRouteName,
//         // path: '/home/:tab(shop|cart|profile)',
//         path: '/home',
//         pageBuilder: (context, state) {
//           final tab = state.params['tab']!;
//           return MaterialPage<void>(
//             key: state.pageKey,
//             child: HomePage(
//               detailsPath: '',
//             ),
//           );
//         },
//         routes: [
//           GoRoute(
//             name: Constants.searchRouteName,
//             path: 'details/:search',
//             pageBuilder: (context, state) => MaterialPage<void>(
//               key: state.pageKey,
//               child: const SearchPage(),
//             ),
//           ),
//           GoRoute(
//             name: Constants.classDetailsRouteName,
//             path: 'classDetails',
//             pageBuilder: (context, state) => MaterialPage<void>(
//               key: state.pageKey,
//               child: const ClassDetailsScreen(),
//             ),
//           ),
//         ],
//       ),
//       // forwarding routes to remove the need to put the 'tab' param in the code
//       // GoRoute(
//       //   path: '/shop',
//       //   redirect: (state) =>
//       //       state.namedLocation(homeRouteName, params: {'tab': 'shop'}),
//       // ),
//       // GoRoute(
//       //   path: '/cart',
//       //   redirect: (state) =>
//       //       state.namedLocation(homeRouteName, params: {'tab': 'cart'}),
//       // ),
//       // GoRoute(
//       //   path: '/profile',
//       //   redirect: (state) =>
//       //       state.namedLocation(homeRouteName, params: {'tab': 'profile'}),
//       // ),
//       // GoRoute(
//       //   name: detailsRouteName,
//       //   path: '/details-redirector/:item',
//       //   redirect: (state) => state.namedLocation(
//       //     subDetailsRouteName,
//       //     params: {'tab': 'shop', 'item': state.params['item']!},
//       //   ),
//       // ),
//       // GoRoute(
//       //   name: personalRouteName,
//       //   path: '/profile-personal',
//       //   redirect: (state) => state.namedLocation(
//       //     profilePersonalRouteName,
//       //     params: {'tab': 'profile'},
//       //   ),
//       // ),
//       // GoRoute(
//       //   name: paymentRouteName,
//       //   path: '/profile-payment',
//       //   redirect: (state) => state.namedLocation(
//       //     profilePaymentRouteName,
//       //     params: {'tab': 'profile'},
//       //   ),
//       // ),
//       // GoRoute(
//       //   name: signinInfoRouteName,
//       //   path: '/profile-signin-info',
//       //   redirect: (state) => state.namedLocation(
//       //     profileSigninInfoRouteName,
//       //     params: {'tab': 'profile'},
//       //   ),
//       // ),
//       // GoRoute(
//       //   name: moreInfoRouteName,
//       //   path: '/profile-more-info',
//       //   redirect: (state) => state.namedLocation(
//       //     profileMoreInfoRouteName,
//       //     params: {'tab': 'profile'},
//       //   ),
//       // ),
//     ],

//     // errorPageBuilder: (context, state) => MaterialPage<void>(
//     //   key: state.pageKey,
//     //   child: ErrorPage(error: state.error),
//     // ),

//     // redirect to the login page if the user is not logged in
//     redirect: (state, context) {
//       final loginLoc = state.namedLocation(Constants.loginRouteName);
//       //final loggingIn = state.sub == loginLoc;
//       final loggedIn = loginState.loggedIn;
//       final rootLoc = state.namedLocation(Constants.rootRouteName);

//       if (!loggedIn) return loginLoc;
//       if (loggedIn) return rootLoc;
//       return null;
//     },
//   );
// }

// // final routerProvider = FutureProvider((ref) async {
// //   final signInState = ref.watch(authControllerProvider);

// //   return MyRouter(signInState).router;
// // });

// // final rotuerRepositoryProvider = Provider<MyRouter>((ref) {
// //    final signInState = ref.watch(loginStateProvider);
// //   return MyRouter(signInState, context);
// // });
