import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../Extensions/extensions.dart';

import '../../app.dart';
import '../Widgets/class_exam_details_info_card.dart';
import '../Widgets/icon_label_details_row.dart';
import '../Models/tasks_due_dataSource.dart';
import '../Widgets/task_due_card.dart';
import '../Widgets/custom_alert.dart';
import '../Models/API/classmodel.dart';
import '../Home_Screens/create_screen.dart';

class ClassDetailsScreen extends ConsumerWidget {
  final ClassModel classItem;
  const ClassDetailsScreen(this.classItem, {super.key});

  void _editButtonPressed(BuildContext context) {
    bottomSheetForSignIn(context);
  }

  bottomSheetForSignIn(BuildContext context) {
    showModalBottomSheet(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        isScrollControlled: true,
        context: context,
        // transitionAnimationController: controller,
        enableDrag: false,
        builder: (context) {
          return CreateScreen(classItem: classItem);
        });
  }

  void _closeButtonPressed(context) {
    Navigator.pop(context);
  }

  void _selectTaskDue(int index) {
    print("CARD SELECTED $index");
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    final List<TaskDueStatic> _tasksDue = TaskDueStatic.tasksDue;

    return Container(
      color: theme == ThemeMode.light
          ? Constants.lightThemeClassExamDetailsBackgroundColor
          : Constants.darkThemeBackgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 206,
            width: double.infinity,
            alignment: Alignment.topCenter,
            child: Image.network(
              classItem.subject?.imageUrl ?? "",
              fit: BoxFit.fill,
              height: 206,
              width: double.infinity,
            ),
          ),
          Container(
            height: 36,
            width: 75,
            margin: const EdgeInsets.only(left: 20, top: 50),
            child: ElevatedButton(
              style: ButtonStyle(
                  elevation: MaterialStateProperty.all(0.0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  )),
                  minimumSize: MaterialStateProperty.all(const Size((75), 45)),
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.white),
                  textStyle: MaterialStateProperty.all(const TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))),
              onPressed: () => _editButtonPressed(context),
              child: const Text("Edit"),
            ),
          ),
          Positioned(
            right: -10,
            top: 45,
            child: MaterialButton(
              splashColor: Colors.transparent,
              elevation: 0.0,
              onPressed: () => _closeButtonPressed(context),
              child: Container(
                height: 36,
                width: 36,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/CloseButtonX.png'),
                        fit: BoxFit.fill)),
              ),
            ),
          ),
          ClassExamDetailsInfoCard(classItem.subject?.colorHex != null
                              ? HexColor.fromHex(classItem.subject!.colorHex!)
                              : Colors.red, "Class", classItem.subject?.subjectName ?? "",
              classItem.module ?? "", classItem.startDate, classItem.startTime),
          Container(
            margin: const EdgeInsets.only(left: 20, top: 349),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconLabelDetailsRow(
                    Image.asset("assets/images/LocationPinGrey.png"),
                    "Where",
                    '${classItem.room ?? ""}, ${classItem.building ?? ""}'),
                Container(
                  height: 8,
                ),
                IconLabelDetailsRow(
                    Image.asset("assets/images/ProfessorIconGrey.png"),
                    "Professor",
                    classItem.teacher ?? ""),
                Container(
                  height: 58,
                ),
                Text(
                  'Tasks due for ${classItem.subject?.subjectName}',
                  style: theme == ThemeMode.light
                      ? Constants.lightThemeRegular14TextSelectedStyle
                      : Constants.darkThemeRegular14TextStyle,
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
            height: double.infinity,
            margin: const EdgeInsets.only(top: 483),
            child: ListView.builder(
                // controller: widget._controller,
                itemCount: classItem.tasks?.length,
                itemBuilder: (context, index) {
                  return TaskDueCardForClassOrExam(
                    index,
                    _tasksDue[index],
                    _selectTaskDue,
                  );
                }),
          ),
        ],
      ),
    );
  }
}
