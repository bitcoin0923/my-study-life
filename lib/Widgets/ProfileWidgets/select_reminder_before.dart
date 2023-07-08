import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';

class SelectReminderBefore extends StatefulWidget {
  final Function reminderSelected;
  final String? type;
  SelectReminderBefore({super.key, required this.reminderSelected, this.type});

  @override
  State<SelectReminderBefore> createState() => _SelectReminderBeforeState();
}

class _SelectReminderBeforeState extends State<SelectReminderBefore> {
  final List<ClassTagItem> _types = ClassTagItem.notificationReminderTimes;

  int selectedTabIndex = 0;

  @override
  void initState() {
    checkifEditing();
    super.initState();
  }

  @override
  void dispose() {
    for (var type in _types) {
      type.selected = false;
    }
    super.dispose();
  }

  void checkifEditing() {
    if (widget.type != null) {
      var firstIndex = _types.indexWhere((element) => element.title .toLowerCase()== widget.type!.toLowerCase());
      _types[firstIndex].selected = true;
    }
  }

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _types) {
        item.selected = false;
      }

      _types[index].selected = true;
      widget.reminderSelected(_types[index]);
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
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remind Me Before',
              style: theme == ThemeMode.light ? Constants.lightThemeSubtitleTextStyle : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: _types
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



