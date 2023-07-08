import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';

enum PersonalizeType {
  dateFormat,
  timeFormat,
  academicIntervals,
  sessionType,
  dayOffType
}

class SelectPeronalizeOptions extends StatefulWidget {
  final Function selectedEntry;
  final String? preselectedtype;
  final PersonalizeType selectionType;

  SelectPeronalizeOptions(
      {super.key,
      this.preselectedtype,
      required this.selectedEntry,
      required this.selectionType});

  @override
  State<SelectPeronalizeOptions> createState() =>
      _SelectPeronalizeOptionsState();
}

class _SelectPeronalizeOptionsState extends State<SelectPeronalizeOptions> {
  final List<ClassTagItem> _dateTypes = ClassTagItem.dateTypes;
  final List<ClassTagItem> _timeTypes = ClassTagItem.timeTypes;
  final List<ClassTagItem> _academicIntervals = ClassTagItem.academicIntervals;
  final List<ClassTagItem> _taughtSessions = ClassTagItem.taughtSessions;
  final List<ClassTagItem> _daysOffssions = ClassTagItem.taughtSedaysOffssions;

  int selectedTabIndex = 0;

  @override
  void initState() {
    checkifEditing();
    super.initState();
  }

  @override
  void dispose() {
    for (var type in _dateTypes) {
      type.selected = false;
    }
    for (var type in _timeTypes) {
      type.selected = false;
    }
    for (var type in _academicIntervals) {
      type.selected = false;
    }
    for (var type in _taughtSessions) {
      type.selected = false;
    }
    for (var type in _daysOffssions) {
      type.selected = false;
    }
    super.dispose();
  }

  void checkifEditing() {
    if (widget.preselectedtype != null) {
      if (widget.selectionType == PersonalizeType.dateFormat) {
        var firstIndex = _dateTypes.indexWhere((element) =>
            element.title.toLowerCase() ==
            widget.preselectedtype!.toLowerCase());
        _dateTypes[firstIndex].selected = true;
      }
      if (widget.selectionType == PersonalizeType.timeFormat) {
        var firstIndex = _timeTypes.indexWhere((element) =>
            element.title.toLowerCase() ==
            widget.preselectedtype!.toLowerCase());
        _timeTypes[firstIndex].selected = true;
      }
      if (widget.selectionType == PersonalizeType.academicIntervals) {
        var firstIndex = _academicIntervals.indexWhere((element) =>
            element.title.toLowerCase() ==
            widget.preselectedtype!.toLowerCase());
        _academicIntervals[firstIndex].selected = true;
      }
      if (widget.selectionType == PersonalizeType.sessionType) {
        var firstIndex = _taughtSessions.indexWhere((element) =>
            element.title.toLowerCase() ==
            widget.preselectedtype!.toLowerCase());
        _taughtSessions[firstIndex].selected = true;
      }
      if (widget.selectionType == PersonalizeType.dayOffType) {
        var firstIndex = _daysOffssions.indexWhere((element) =>
            element.title.toLowerCase() ==
            widget.preselectedtype!.toLowerCase());
        _daysOffssions[firstIndex].selected = true;
      }
    }
  }

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      if (widget.selectionType == PersonalizeType.dateFormat) {
        for (var item in _dateTypes) {
          item.selected = false;
        }

        _dateTypes[index].selected = true;
        widget.selectedEntry(_dateTypes[index]);
      }
      if (widget.selectionType == PersonalizeType.timeFormat) {
        for (var item in _timeTypes) {
          item.selected = false;
        }

        _timeTypes[index].selected = true;
        widget.selectedEntry(_timeTypes[index]);
      }
      if (widget.selectionType == PersonalizeType.academicIntervals) {
        for (var item in _academicIntervals) {
          item.selected = false;
        }

        _academicIntervals[index].selected = true;
        widget.selectedEntry(_academicIntervals[index]);
      }
      if (widget.selectionType == PersonalizeType.sessionType) {
        for (var item in _taughtSessions) {
          item.selected = false;
        }

        _taughtSessions[index].selected = true;
        widget.selectedEntry(_taughtSessions[index]);
      }
      if (widget.selectionType == PersonalizeType.dayOffType) {
        for (var item in _daysOffssions) {
          item.selected = false;
        }

        _daysOffssions[index].selected = true;
        widget.selectedEntry(_daysOffssions[index]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        // Tag items
        // height: 34,
        width: double.infinity,
        alignment: Alignment.topCenter,
        // height: 200,
        margin: const EdgeInsets.only(left: 22, right: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.selectionType == PersonalizeType.dateFormat) ...[
              Text(
                'Date format you prefer',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeSubtitleTextStyle
                    : Constants.darkThemeSubtitleTextStyle,
                textAlign: TextAlign.left,
              ),
              Container(
                height: 14,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: _dateTypes
                    .mapIndexed((e, i) => TagCard(
                          title: e.title,
                          selected: e.selected,
                          cardIndex: e.cardIndex,
                          cardselected: _selectTab,
                          isAddNewCard: e.isAddNewCard,
                        ))
                    .toList(),
              ),
              Container(
                height: 40,
              ),
            ],
            if (widget.selectionType == PersonalizeType.timeFormat) ...[
              Text(
                'Time format you prefer',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeSubtitleTextStyle
                    : Constants.darkThemeSubtitleTextStyle,
                textAlign: TextAlign.left,
              ),
              Container(
                height: 14,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: _timeTypes
                    .mapIndexed((e, i) => TagCard(
                          title: e.title,
                          selected: e.selected,
                          cardIndex: e.cardIndex,
                          cardselected: _selectTab,
                          isAddNewCard: e.isAddNewCard,
                        ))
                    .toList(),
              ),
              Container(
                height: 40,
              ),
            ],
            if (widget.selectionType == PersonalizeType.academicIntervals) ...[
              Text(
                'What do you call your academic intervals?',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeSubtitleTextStyle
                    : Constants.darkThemeSubtitleTextStyle,
                textAlign: TextAlign.left,
              ),
              Container(
                height: 14,
              ),
              Text(
                maxLines: 2,
                "What do you call periods of instruction which an academic year is often divided into?",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: theme == ThemeMode.light
                        ? Colors.black.withOpacity(0.7)
                        : Colors.white.withOpacity(0.7)),
              ),
              Container(
                height: 14,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: _academicIntervals
                    .mapIndexed((e, i) => TagCard(
                          title: e.title,
                          selected: e.selected,
                          cardIndex: e.cardIndex,
                          cardselected: _selectTab,
                          isAddNewCard: e.isAddNewCard,
                        ))
                    .toList(),
              ),
              Container(
                height: 40,
              ),
            ],
            if (widget.selectionType == PersonalizeType.sessionType) ...[
              Text(
                'What do you call your taught sessions?',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeSubtitleTextStyle
                    : Constants.darkThemeSubtitleTextStyle,
                textAlign: TextAlign.left,
              ),
              Container(
                height: 14,
              ),
              Text(
                maxLines: 2,
                "What do you call the times when you are being taught by a teacher/lecturer?",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: theme == ThemeMode.light
                        ? Colors.black.withOpacity(0.7)
                        : Colors.white.withOpacity(0.7)),
              ),
              Container(
                height: 14,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: _taughtSessions
                    .mapIndexed((e, i) => TagCard(
                          title: e.title,
                          selected: e.selected,
                          cardIndex: e.cardIndex,
                          cardselected: _selectTab,
                          isAddNewCard: e.isAddNewCard,
                        ))
                    .toList(),
              ),
              Container(
                height: 40,
              ),
            ],
            if (widget.selectionType == PersonalizeType.dayOffType) ...[
              Text(
                'What do you preffer calling your days off?',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeSubtitleTextStyle
                    : Constants.darkThemeSubtitleTextStyle,
                textAlign: TextAlign.left,
              ),
              Container(
                height: 14,
              ),
              Text(
                maxLines: 2,
                "What do you call the periods of time when you do not atend school?",
                style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.normal,
                    color: theme == ThemeMode.light
                        ? Colors.black.withOpacity(0.7)
                        : Colors.white.withOpacity(0.7)),
              ),
              Container(
                height: 14,
              ),
              Wrap(
                direction: Axis.horizontal,
                alignment: WrapAlignment.start,
                children: _daysOffssions
                    .mapIndexed((e, i) => TagCard(
                          title: e.title,
                          selected: e.selected,
                          cardIndex: e.cardIndex,
                          cardselected: _selectTab,
                          isAddNewCard: e.isAddNewCard,
                        ))
                    .toList(),
              ),
              Container(
                height: 40,
              ),
            ],
          ],
        ),
      );
    });
  }
}
