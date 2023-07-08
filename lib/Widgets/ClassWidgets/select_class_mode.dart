import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';


class SelectClassMode extends StatefulWidget {
  final Function subjectSelected;
  final bool? isClassInPerson;
  SelectClassMode({super.key, required this.subjectSelected, this.isClassInPerson});

  @override
  State<SelectClassMode> createState() => _SelectClassModeState();
}

class _SelectClassModeState extends State<SelectClassMode> {
  final List<ClassTagItem> _subjects = ClassTagItem.subjectModes;

  @override
  void initState() {
    if (widget.isClassInPerson != null) {
      if (widget.isClassInPerson == false) {
        var mode = _subjects[1];
        mode.selected = true;
        _subjects[1] = mode;
      }
      else {
         var mode = _subjects[0];
        mode.selected = true;
        _subjects[0] = mode;
      }
    }
    super.initState();
  }

    @override
  void dispose() {
    for (var mode in _subjects) {
      mode.selected = false;
    }
    super.dispose();
  }

  int selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _subjects) {
        item.selected = false;
      }

      _subjects[index].selected = true;
      widget.subjectSelected(_subjects[index]);
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
              'Mode',
              style: theme == ThemeMode.light ? Constants.lightThemeSubtitleTextStyle : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: _subjects
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
