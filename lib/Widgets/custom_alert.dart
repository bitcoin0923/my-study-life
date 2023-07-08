import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import '../Utilities/constants.dart';

import '../app.dart';

class CustomAlertView extends ConsumerWidget {
  const CustomAlertView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    return Container(
      color: Colors.black.withOpacity(0.1),
      // child: Positioned(
      //   bottom: 65,
        child: Container(
         // height: 282,
          width: 293,
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(left: 41, right: 41, bottom: 65, top: 200),
          decoration: BoxDecoration(
            color: theme == ThemeMode.light
                ? Constants.lightThemeBackgroundColor
                : Constants.darkThemeClassExamCardBackgroundColor,
            border: Border.all(
              color: theme == ThemeMode.light
                ? Constants.lightThemeBackgroundColor
                : Constants.darkThemeClassExamCardBackgroundColor,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
     // ),
    );
  }
}
