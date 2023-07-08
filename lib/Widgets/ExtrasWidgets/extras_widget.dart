import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_study_life_flutter/Extensions/extensions.dart';
import 'package:intl/intl.dart';
import 'package:group_list_view/group_list_view.dart';

import '../../app.dart';
import '../../Models/holidays_datasource.dart';
import '../../Utilities/constants.dart';
import '../../Models/API/xtra.dart';

class ExtrasWidget extends ConsumerWidget {
  final IndexPath cardIndex;
  final bool upNext;

  final Xtra xtraItem;
  final Function cardselected;

  const ExtrasWidget(
      {super.key,
      required this.xtraItem,
      required this.cardIndex,
      required this.upNext,
      required this.cardselected});

  void _cardTapped() {
    cardselected(cardIndex, xtraItem);
  }

  String _getFormattedTime(DateTime time) {
    var localDate = time.toLocal();
    var inputFormat = DateFormat('yyyy-MM-dd HH:mm');
    var inputDate = inputFormat.parse(localDate.toString());

    if (time.isToday()) {
      var outputFormat = DateFormat('HH:mm');
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    } else {
      var outputFormat = DateFormat('EEE, d MMM ');
      var outputDate = outputFormat.format(inputDate);
      return outputDate.toString();
    }
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
          height: xtraItem.imageUrl != null ? 103 : 73,
          child: Stack(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 18, top: 18, bottom: 18, right: 150),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        xtraItem.name ?? "",
                        maxLines: 4,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: theme == ThemeMode.light
                                ? Constants.lightThemeTextSelectionColor
                                : Colors.white),
                      ),
                    ),
                    Text(
                      xtraItem.endDate != null
                          ? '${_getFormattedTime(xtraItem.getStartDate())} - ${_getFormattedTime(xtraItem.getEndDate())}'
                          : _getFormattedTime(xtraItem.getStartDate()),
                      style: theme == ThemeMode.light
                          ? Constants.lightTHemeClassDateTextStyle
                          : Constants.darkTHemeClassDateTextStyle,
                    ),
                  ],
                ),
              ),
              if (xtraItem.imageUrl != null) ...[
                Positioned(
                  right: 20,
                  top: 11,
                  bottom: 11,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    height: 71,
                    width: 79,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: FittedBox(
                        fit: BoxFit.fill,
                        // clipBehavior: Clip.hardEdge,
                        child: Image.asset(
                          xtraItem.imageUrl ?? "",
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
