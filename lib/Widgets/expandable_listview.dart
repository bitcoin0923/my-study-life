import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';
import '.././Widgets/exam_widget.dart';
import '../Models/exam_datasource.dart';
import '../Home_Screens/exam_details_screen.dart';
import '../Models/task_datasource.dart';
import '../Widgets/TaskWidgets/task_widget.dart';
import '../Models/API/exam.dart';
import '../Models/API/task.dart';
import '../Activities_Screens/task_detail_screen.dart';

class ExpandableListView extends StatefulWidget {
  final String period;
  final String numberOfItems;
  final List<Exam>? exams;
  final List<Task>? tasks;

  const ExpandableListView(
      {Key? key,
      required this.period,
      required this.numberOfItems,
      this.exams,
      this.tasks})
      : super(key: key);

  @override
  _ExpandableListViewState createState() => _ExpandableListViewState();
}

class _ExpandableListViewState extends State<ExpandableListView> {
  bool expandFlag = false;

  void _selectedExamCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>  ExamDetailsScreen(examItem: widget.exams![index]),
            fullscreenDialog: true));
  }

  void _selectedTaskCard(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => TaskDetailsScreen(widget.tasks![index]),
            fullscreenDialog: true));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final theme = ref.watch(themeModeProvider);

        return Container(
          // margin: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: theme == ThemeMode.light
                      ? Colors.white
                      : Colors.white.withOpacity(0.1),
                  border: Border.all(
                    width: theme == ThemeMode.dark ? 1 : 0,
                    color: theme == ThemeMode.dark
                        ? Colors.transparent
                        : Colors.black.withOpacity(0.2),
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      widget.period,
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeRegular14TextStyle
                          : Constants.darkThemeRegular14TextStyle,
                    ),
                    Text(
                      widget.numberOfItems,
                      style: theme == ThemeMode.light
                          ? Constants.lightThemeSubtitleTextStyle
                          : Constants.darkThemeSubtitleTextStyle,
                    ),
                    IconButton(
                        icon: Container(
                          height: 50.0,
                          width: 50.0,
                          // decoration: const BoxDecoration(
                          //   color: Colors.orange,
                          //   shape: BoxShape.circle,
                          // ),
                          child: Center(
                            child: expandFlag
                                ? theme == ThemeMode.light
                                    ? Image.asset(
                                        'assets/images/ExpandableSectionArrowBlack.png')
                                    : Image.asset(
                                        'assets/images/ExpandableSectionArrowWhiteUp.png')
                                : theme == ThemeMode.light
                                    ? Image.asset(
                                        'assets/images/ExpandableSectionArrowBlackDown.png')
                                    : Image.asset(
                                        'assets/images/ExpandableSectionArrowWhiteDown.png'),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            expandFlag = !expandFlag;
                          });
                        }),
                  ],
                ),
              ),
              Container(
                height: 20,
              ),
              ExpandableContainer(
                  expanded: expandFlag,
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      if (widget.exams != null) {
                        return ExamWidget(
                            examItem: widget.exams![index],
                            cardIndex: index,
                            upNext: true,
                            cardselected: _selectedExamCard);
                      } else {
                        return TaskWidget(
                            taskItem: widget.tasks![index],
                            cardIndex: index,
                            upNext: true,
                            cardselected: _selectedTaskCard);
                      }
                    },
                    itemCount: widget.exams != null ? widget.exams!.length : widget.tasks!.length,
                  ))
            ],
          ),
        );
      },
    );
  }
}

class ExpandableContainer extends StatelessWidget {
  final bool expanded;
  final double collapsedHeight;
  final double expandedHeight;
  final Widget child;

  ExpandableContainer({
    required this.child,
    this.collapsedHeight = 0.0,
    this.expandedHeight = 300.0,
    this.expanded = true,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
      width: screenWidth,
      height: expanded ? expandedHeight : collapsedHeight,
      child: Container(
        child: child,
        // decoration:
        //     BoxDecoration(border: Border.all(width: 1.0, color: Colors.blue)),
      ),
    );
  }
}
