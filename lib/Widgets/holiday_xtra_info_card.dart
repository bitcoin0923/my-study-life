import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../Models/holidays_datasource.dart';
import '../../app.dart';
import '../Models/API/holiday.dart';
import '../Models/API/xtra.dart';

class HolidayXtraInfoInfoCard extends ConsumerWidget {
  final Holiday? item;
  final Xtra? xtraItem;
  const HolidayXtraInfoInfoCard(this.item, this.xtraItem, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    final startDateString =
        DateFormat('EEE, dd, MMM').format(item != null ? item!.getStartDate() : xtraItem!.getStartDate());

    return Container(
      //  height: 154,
      margin: const EdgeInsets.only(left: 40, right: 40, bottom: 20),
      decoration: BoxDecoration(
        color: theme == ThemeMode.light
            ? Colors.white
            : Constants.darkThemeSecondaryBackgroundColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
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
      child: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title
            Container(
              child: Expanded(
                child: Text(
                  item != null ? item!.title ?? "" : xtraItem!.name ?? "",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    color: theme == ThemeMode.light
                        ? Constants.lightThemeTextSelectionColor
                        : Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              height: 23,
            ),
            Container(
              height: 18,
              child: Text(
                item != null ? "Holiday" : "Xtra",
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                  color: theme == ThemeMode.light ? Colors.black : Colors.white,
                ),
              ),
            ),
            Container(
              height: 20,
            ),
            Container(
              height: 24,
              child: Text(
                startDateString,
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                  color: theme == ThemeMode.light ? Colors.black : Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
