import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';

import '../../app.dart';

class CustomSegmentedControl extends ConsumerWidget {
  final Map<int, Widget> tabs;
  final Function valueChanged;
  const CustomSegmentedControl(this.valueChanged, {super.key, required this.tabs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return CustomSlidingSegmentedControl<int>(
      isStretch: true,
      initialValue: 1,
      children: tabs,
      decoration: BoxDecoration(
        color: theme == ThemeMode.light
            ? Constants.lightThemeSecondaryColor
            : Constants.darkThemeDividerColor,
        borderRadius: BorderRadius.circular(8),
      ),
      thumbDecoration: BoxDecoration(
        color: theme == ThemeMode.light
            ? Constants.lightThemePrimaryColor
            : Constants.darkThemePrimaryColor,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 2.0,
            spreadRadius: 1.0,
            offset: Offset(
              0.0,
              2.0,
            ),
          ),
        ],
      ),
      duration: Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      onValueChanged: (v) {
        valueChanged(v);
      },
    );
  }
}
