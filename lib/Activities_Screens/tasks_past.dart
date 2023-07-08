import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';
import '../../app.dart';
import "package:collection/collection.dart";
import 'package:group_list_view/group_list_view.dart';
import '../Widgets/expandable_listview.dart';
import 'package:intl/intl.dart';

import '../Models/task_datasource.dart';
import '../Extensions/extensions.dart';
import '../Widgets/TaskWidgets/task_widget.dart';
import '../Models/API/task.dart';
import '../Activities_Screens/task_detail_screen.dart';

class TasksPastList extends ConsumerWidget {
  final Map<int, List<Task>> groupedByDate;
  final List<int> groupedKeys;

  TasksPastList(this.groupedByDate, this.groupedKeys, {super.key});
  final ScrollController scrollcontroller = ScrollController();
  //final List<TaskItem> _tasks = TaskItem.thisMonthTasks;

  void _selectedCard(int index) {
    //  Navigator.push(
    //     scaffoldMessengerKey.currentState!.context,
    //     MaterialPageRoute(
    //         builder: (context) => TaskDetailsScreen(widget.tasks![index]),
    //         fullscreenDialog: true));
  }

   String getMonthName(int monthNumber) {
    var currentDate = DateTime.now();
    var currentMonth = currentDate.month;
    String formattedDate = DateFormat('MMM, yyyy').format(currentDate);
    String formattedYear = DateFormat('yyyy').format(currentDate);

    if (monthNumber == currentMonth) {
      return "Earlier this month - $formattedDate";
    } else {
      switch (monthNumber) {
        case 1:
          return "Jan, $formattedYear                                 ";
        case 2:
          return "Feb, $formattedYear                                 ";
        case 3:
          return "Mar, $formattedYear                                 ";
        case 4:
          return "Apr, $formattedYear                                 ";
        case 5:
          return "May, $formattedYear                                 ";
        case 6:
          return "Jun, $formattedYear                                 ";
        case 7:
          return "Jul, $formattedYear                                 ";
        case 8:
          return "Aug, $formattedYear                                 ";
        case 9:
          return "Sep, $formattedYear                                 ";
        case 10:
          return "Oct, $formattedYear                                 ";
        case 11:
          return "Nov, $formattedYear                                 ";
        case 12:
          return "Dec, $formattedYear                                 ";

        default:
          formattedYear;
      }
    }
    return formattedYear;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    // var groupByDate = groupBy(_tasks, (obj) => obj.date.isToday());

    return Container(
      margin: const EdgeInsets.only(top: 164),
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return ExpandableListView(
            period: getMonthName(groupedKeys.reversed.toList()[index]),
            numberOfItems: "${groupedByDate[groupedKeys.toList()[index]]?.length}",
            tasks: groupedByDate[groupedKeys[index]],
          );
        },
        itemCount: groupedKeys.reversed.length,
      ),
    );
  }
}
