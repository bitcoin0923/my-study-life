import 'package:flutter/material.dart';

import '../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';

class TagCard extends StatelessWidget {
  final String title;
  final bool selected;
  final int cardIndex;
  final Function cardselected;
  final bool isAddNewCard;

  const TagCard(
      {super.key,
      required this.title,
      required this.selected,
      required this.cardIndex,
      required this.cardselected,
      required this.isAddNewCard});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Card(
        color: selected
            ? theme == ThemeMode.light
                ? Constants.lightThemePrimaryColor
                : Constants.darkThemePrimaryColor
            : theme == ThemeMode.light
                ? Constants.lightThemeNotSelectedItemColor
                : Constants.darkThemeNotSelectedItemColor,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        child: InkWell(
          onTap: _cardTapped,
          child: Container(
            height: 34,
            // alignment: Alignment.center,
            padding: const EdgeInsets.only(left: 17, right: 17, top: 9),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: isAddNewCard
                  ? selected
                      ? theme == ThemeMode.light
                          ? Constants.lightThemeMedium14SelectedTextStyle
                          : Constants.darkThemeMedium14SelectedTextStyle
                      : theme == ThemeMode.light
                          ? Constants.lightThemeMedium14TextStyle
                          : Constants.darkThemeMedium14TextStyle
                  : selected
                      ? theme == ThemeMode.light
                          ? Constants.lightThemeRegular14TextSelectedStyle
                          : Constants.darkThemeRegular14TextSelectedStyle
                      : theme == ThemeMode.light
                          ? Constants.lightThemeRegular14TextStyle
                          : Constants.darkThemeRegular14TextStyle,
            ),
          ),
        ),
      );
    });
  }
}
