import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:my_study_life_flutter/Home_Screens/class_details_screen.dart';

import './app.dart';
import './tab_item.dart';
import './Utilities/constants.dart';
import 'Onboarding_Screens/get_started.dart';
import './Controllers/auth_controller.dart';
import './Onboarding_Screens/signup.dart';
import './Onboarding_Screens/login.dart';
import './Onboarding_Screens/forgot_password.dart';
import './Home_Screens/home_page.dart';
import './bottom_navigation.dart';
import 'Home_Screens/create_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
  
//   runApp(const ProviderScope(child: MyStudyLife()));
// }

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    overrides: [
      // override the previous value with the new object
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: App(),
  ));
}

// class MyStudyLife extends ConsumerWidget {
//   const MyStudyLife({super.key});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return MyApp();
//   }
// }
