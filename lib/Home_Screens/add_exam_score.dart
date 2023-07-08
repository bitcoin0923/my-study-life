import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '../../Models/subjects_datasource.dart';

import '../app.dart';
import '../Widgets/tag_card.dart';
import '../Widgets/regular_teztField.dart';

class AddScoreScreen extends StatefulWidget {
  const AddScoreScreen({super.key});

  @override
  State<AddScoreScreen> createState() => _AddScoreScreenState();
}

class _AddScoreScreenState extends State<AddScoreScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<ClassTagItem> _types = ClassTagItem.scoreTypes;
  final textController = TextEditingController();

  int selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      for (var item in _types) {
        item.selected = false;
      }

      _types[index].selected = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1600,
      ),
    );

    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return BottomSheet(
        
        animationController: _controller,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height - 340,
            color: theme == ThemeMode.light
                ? Constants.lightThemeBackgroundColor
                : Constants.darkThemeBackgroundColor,
            child: Stack(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 28),
                  alignment: Alignment.topCenter,
                  child: Text(
                    'Exam Score',
                    style: theme == ThemeMode.light
                        ? Constants.lightThemeTitleTextStyle
                        : Constants.darkThemeTitleTextStyle,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 18, left: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeNavigationButtonStyle
                          : Constants.darkThemeNavigationButtonStyle,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 18, right: 20),
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Save',
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeNavigationButtonStyle
                          : Constants.darkThemeNavigationButtonStyle,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 36, top: 85, right: 36),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Score Type*',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
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
                      Container(
                        height: 22,
                      ),
                      Text(
                        'Score*',
                        style: theme == ThemeMode.light
                            ? Constants.lightThemeSubtitleTextStyle
                            : Constants.darkThemeSubtitleTextStyle,
                        textAlign: TextAlign.left,
                      ),
                      Container(
                        height: 6,
                      ),
                      RegularTextField("Score", (value) {
                        FocusScope.of(context).unfocus();
                      }, TextInputType.emailAddress, textController,
                          theme == ThemeMode.dark, autofocus: false,),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        onClosing: () {
          // Navigator.pop(context);
        },
      );
    });
  }
}
