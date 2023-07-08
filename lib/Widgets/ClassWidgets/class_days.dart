import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';
import '../../Models/API/classmodel.dart';
import '../../Models/API/xtra.dart';

class ClassWeekDays extends StatefulWidget {
  final Function subjectSelected;
  final ClassModel? classItem;
  final Xtra? xtraItem;

  ClassWeekDays(
      {super.key,
      required this.subjectSelected,
      this.classItem,
      this.xtraItem});

  @override
  State<ClassWeekDays> createState() => _ClassWeekDaysState();
}

class _ClassWeekDaysState extends State<ClassWeekDays> {
  final List<ClassTagItem> _days = ClassTagItem.classDays;

  @override
  void initState() {
    super.initState();
    if (widget.classItem != null) {
      if (widget.classItem?.occurs == "repeating") {
        for (var day in widget.classItem?.days ?? []) {
          var selectedIndex = _days.indexWhere(
              (element) => element.title.toLowerCase() == day.toLowerCase());
          _days[selectedIndex].selected = true;
        }
      }
    }
    if (widget.xtraItem != null) {
      if (widget.xtraItem?.occurs == "repeating") {
        for (var day in widget.xtraItem?.days ?? []) {
          var selectedIndex = _days.indexWhere(
              (element) => element.title.toLowerCase() == day.toLowerCase());
          _days[selectedIndex].selected = true;
        }
      }
    }
  }

  @override
  void dispose() {
    for (var day in _days) {
      day.selected = false;
    }
    super.dispose();
  }

  void _selectTab(int index) {
    setState(() {
      // for (var item in _repetitions) {
      //   item.selected = false;
      // }

      _days[index].selected = !_days[index].selected;
      widget.subjectSelected(_days);
      // print("CARD SELECTED $index");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        // Tag items
        width: double.infinity,
        alignment: Alignment.topCenter,
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Days*',
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
              children: _days
                  .mapIndexed((e, i) => TagCard(
                        title: e.title,
                        selected: e.selected,
                        cardIndex: e.cardIndex,
                        cardselected: _selectTab,
                        isAddNewCard: e.isAddNewCard,
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
