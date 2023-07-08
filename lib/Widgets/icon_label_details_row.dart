import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';

import '../../app.dart';

class IconLabelDetailsRow extends ConsumerWidget {
  final Image iconImage;
  final String labelName;
  final String value;

  const IconLabelDetailsRow(this.iconImage, this.labelName, this.value,
      {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        iconImage,
        Container(
          width: 8,
        ),
        Text(
          labelName,
          style: theme == ThemeMode.light
              ? Constants.lightThemeRegular14HalfOppacityTextSelectedStyle
              : Constants.darkThemeRegular14HalfOppacityTextSelectedStyle,
        ),
         Container(
          width: 8,
        ),
         Text(
          value,
          style: theme == ThemeMode.light
              ? Constants.lightThemeRegular14TextStyle
              : Constants.darkThemeRegular14TextStyle,
        ),
      ],
    );
  }
}
