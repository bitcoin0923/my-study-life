import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

import '../../../app.dart';
import '../../../Models/class_datasource.dart';
import '../../../Utilities/constants.dart';

class ProfilePersonalizationCard extends ConsumerWidget {
  final int cardIndex;
  final String title;

  final Function cardselected;

  const ProfilePersonalizationCard({
    super.key,
    required this.cardIndex,
    required this.cardselected,
    required this.title,
  });

  void _cardTapped() {
    cardselected(cardIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, top: 2),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(5.0),
          topLeft: Radius.circular(5.0),
        ),
        boxShadow: [
          BoxShadow(
            color: theme == ThemeMode.light
                ? Colors.black.withOpacity(0.08)
                : Colors.white.withOpacity(0.08),
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Card(
        margin: const EdgeInsets.all(5),
        color: theme == ThemeMode.light
            ? Colors.white
            : Constants.darkThemeSecondaryBackgroundColor,
        shadowColor: Colors.transparent,
        // elevation: 10,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: InkWell(
          onTap: _cardTapped,
          child: Container(
            height: 53,
            padding:
                const EdgeInsets.only(top: 18, bottom: 17, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(title,
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          color: theme == ThemeMode.light
                              ? Colors.black
                              : Colors.white)),
                ),
                Container(
                  child: theme == ThemeMode.light
                      ? Image.asset("assets/images/ArrowBlack.png")
                      : Image.asset("assets/images/ArrowWhite.png"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
