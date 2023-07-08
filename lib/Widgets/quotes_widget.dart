import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import '../Models/exam_datasource.dart';

class QuotesWidget extends ConsumerWidget {
  final int cardIndex;
  final String quote;
  final Function cardselected;

  const QuotesWidget(
      {super.key,
      required this.quote,
      required this.cardIndex,
      required this.cardselected});

  void _cardTapped() {
    cardselected(cardIndex);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return Card(
      margin: const EdgeInsets.only(top: 6, bottom: 6, right: 20, left: 20),
      color: theme == ThemeMode.light
          ? Colors.white
          : Constants.darkThemeSecondaryBackgroundColor,
      shadowColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: InkWell(
        onTap: _cardTapped,
        child: Container(
          margin: EdgeInsets.only(left: 25,top: 12,bottom: 12,right: 25),
          height: 103,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '"',
                style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color:theme == ThemeMode.light ? Constants.lightThemeTextSecondaryColor : Colors.white,)
              ),
              Text(quote, style: TextStyle(
                    fontSize: 15,
                    fontFamily: 'Roboto-BoldItalic',
                    fontWeight: FontWeight.w700,
                    color:theme == ThemeMode.light ? Constants.lightThemeTextSecondaryColor : Constants.darkThemeTextSecondaryColor),),
            ],
          ),
        ),
      ),
    );
  }
}
