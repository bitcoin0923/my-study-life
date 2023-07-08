import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../Utilities/constants.dart';

class DetailsTasksDueCard extends ConsumerWidget {
  final Color subjectMainColor;
  final String taskDescription;
  final String subject;
  final DateTime dueDate;

  const DetailsTasksDueCard({
    super.key,
    required this.subjectMainColor,
    required this.taskDescription,
    required this.subject,
    required this.dueDate,
  });

  void _cardTapped() {}

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeModeProvider);
    return Card(
      color: theme == ThemeMode.light ? Colors.white : Constants.darkThemeClassExamCardBackgroundColor,
      shadowColor: Colors.black.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      child: InkWell(
        onTap: _cardTapped,
        child: Container(
          height: 91,
         // padding: const EdgeInsets.only(left: 17, right: 17),
            child: Stack(
              children: [
                Container(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                  ],
                ),
              ],
            ),
          ),
        ),
      );
  }
}
