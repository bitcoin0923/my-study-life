import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Profile_Screens/general_settings_screen.dart';
import '../../Models/class_datasource.dart';

class RotationScheduleSelector extends StatefulWidget {
  final Function rotationSelected;
  RotationScheduleSelector({super.key, required this.rotationSelected});

  @override
  State<RotationScheduleSelector> createState() => _RotationScheduleSelectorState();
}

class _RotationScheduleSelectorState extends State<RotationScheduleSelector> {

  static List<RotationScheduleItem> _rotationItems = RotationScheduleItem.rotationItems;

  int selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _rotationItems) {
        item.selected = false;
      }

      _rotationItems[index].selected = true;
      widget.rotationSelected(_rotationItems[index]);
      print("CARD SELECTED $index");
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
              'Rotation Schedule',
              style: theme == ThemeMode.light ? Constants.lightThemeSubtitleTextStyle : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 14,
            ),
            Wrap(
              direction: Axis.horizontal,
              alignment: WrapAlignment.start,
              children: _rotationItems
                  .mapIndexed((e, i) => TagCard(
                        title: e.rotation.name,
                        selected: e.selected,
                        cardIndex: e.cardIndex,
                        cardselected: _selectTab,
                        isAddNewCard: false,
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
