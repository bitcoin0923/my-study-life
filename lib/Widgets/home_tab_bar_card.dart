import 'package:flutter/material.dart';

import '../Utilities/constants.dart';

class TabBarCard extends StatelessWidget {
  final String title;
  final int badgeNumber;
  final bool selected;
  final bool isLightTheme;
  final int cardIndex;
  final Function cardselected;

  const TabBarCard(
      {super.key,
      required this.title,
      required this.badgeNumber,
      required this.selected,
      required this.isLightTheme,
      required this.cardIndex,
      required this.cardselected});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: selected
          ? isLightTheme
              ? Constants.lightThemePrimaryColor
              : Constants.darkThemePrimaryColor
          : isLightTheme
              ? Constants.lightThemeNotSelectedItemColor
              : Constants.darkThemeNotSelectedItemColor,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: InkWell(
        onTap: _cardTapped,
        child: Container(
          height: 64,
          padding: const EdgeInsets.only(left: 17, right: 17),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                badgeNumber.toString(),
                style: Constants.tabItemBadgeTextStyle,
              ),
              Text(
                " ",
                style: Constants.tabItemBadgeTextStyle,
              ),
              Text(
                title,
                style: Constants.tabItemTitleTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
