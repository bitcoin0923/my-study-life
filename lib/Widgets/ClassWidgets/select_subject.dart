import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';

import '../../app.dart';
import '../tag_card.dart';
import '../../Models/subjects_datasource.dart';
import '../../Models/API/subject.dart';

enum TagType { subjects, exams, tasks, addNew }

class SelectSubject extends StatefulWidget {
  final Function subjectSelected;
  final List<Subject> subjects;
  final TagType tagtype;
  const SelectSubject(
      {super.key,
      required this.subjectSelected,
      required this.subjects,
      required this.tagtype});

  @override
  State<SelectSubject> createState() => _SelectSubjectState();
}

class _SelectSubjectState extends State<SelectSubject> {

  int selectedTabIndex = 0;

  void _selectTab(int index) {
    setState(() {
      selectedTabIndex = index;
      if (widget.tagtype == TagType.subjects) {
        // Subjects
        for (var item in widget.subjects) {
          item.selected = false;
        }

        widget.subjects[index].selected = true;
        widget.subjectSelected(widget.subjects[index]);
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
        margin: const EdgeInsets.only(left: 40, right: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select subject*',
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
              children: widget.subjects
                  .mapIndexed((e, i) => TagCard(
                        title: e.subjectName ?? "",
                        selected: e.selected ?? false,
                        cardIndex: i,
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
