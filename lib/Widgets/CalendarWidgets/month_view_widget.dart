import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../Models/API/event.dart';
import '../../Extensions/extensions.dart';
import '../../Utilities/constants.dart';

class MonthViewWidget extends ConsumerWidget {
  final GlobalKey<MonthViewState>? state;
  final double? width;
  final Function pageChanged;
  final Function daySelected;
  final DateTime currentSelectedDay;

   MonthViewWidget({
    Key? key,
    this.state,
    this.width,
    required this.currentSelectedDay,
    required this.pageChanged,
    required this.daySelected
  }) : super(key: key);

  // void _page() {
    
  //   state?.currentState?.nextPage();
  // }

  String getWeekDatyString(int day) {
    switch (day) {
      case 0:
        return "Mon";
      case 1:
        return "Tue";
      case 2:
        return "Wed";
      case 3:
        return "Thu";
      case 4:
        return "Fri";
      case 5:
        return "Sat";
      case 6:
        return "Sun";
      default:
        return "Mon";
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);

    return MonthView<Event>(
      key: state,
      width: width,
      cellAspectRatio: 1.3,
      headerBuilder: (date) {
        return Container(
          height: 0,
          //child: Text(date.weekdayToAbbreviatedString),
        );
      },
      // borderSize: 0.3,
      showBorder: false,
      weekDayBuilder: (day) {
        return Container(
          color: theme == ThemeMode.light ? Colors.white : Constants.darkThemeSecondaryBackgroundColor,
          height: 44,
          child: Center(
            child: Text(
              getWeekDatyString(day),
              style: theme == ThemeMode.light
                  ? Constants.lightThemeRegular8TextSelectedStyle
                  : Constants.darkThemeRegular8TextSelectedStyle,
            ),
          ),
        );
      },
      cellBuilder: (date, events, isToday, isInMonth) {
        // Return your widget to display as month cell.
        return Container(
          height: 50,
          //width: 48,
          decoration: BoxDecoration(
            color: theme == ThemeMode.light ? Colors.white : Constants.darkThemeSecondaryBackgroundColor,
            border: Border(
              top: BorderSide(width: 0.3, color: Colors.grey.withOpacity(0.4)),
            ),
          ),
          child: Stack(
            children: [
              if (isToday) ...[
                Center(
                  child: Container(
                    height: 34,
                    width: 34,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                    
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                )
              ],
              if (date == currentSelectedDay) ...[
                 Center(
                  child: Container(
                    height: 34,
                    width: 34,
                    margin: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Constants.lightThemePrimaryColor,
                    
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                )
              ],
              Center(
                child: Text(
                  "${date.day}",
                  style: theme == ThemeMode.light
                      ? isInMonth
                          ? Constants.lightThemeRegular10TextSelectedStyle
                          : Constants
                              .lightThemeRegular10TextSelectedStyleWithOpacity
                      : isInMonth
                          ? Constants.darkThemeRegular10TextSelectedStyle
                          : Constants
                              .darkThemeRegular10TextSelectedStyleWithOpacity,
                ),
              ),
            ],
          ),
        );
      },
      onPageChange: (date, page) => pageChanged(date, page),
      onCellTap: (events, date) => daySelected(events, date),
    );
  }
}
