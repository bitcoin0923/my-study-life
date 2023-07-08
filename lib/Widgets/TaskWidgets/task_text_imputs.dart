import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../regular_teztField.dart';
import '../../app.dart';
import '../multiline_textField.dart';

class TaskTextImputs extends StatefulWidget {
  final Function titleFormFilled;
  final Function detailsFormFilled;
  final String labelTitle;
  final String hintText;

  const TaskTextImputs(
      {super.key,
      required this.detailsFormFilled,
      required this.labelTitle,
      required this.hintText,
      required this.titleFormFilled});

  @override
  State<TaskTextImputs> createState() => _TaskTextImputsState();
}

class _TaskTextImputsState extends State<TaskTextImputs> {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();

  void _multilineFormSubmitted(String text) {
    widget.detailsFormFilled(text);
  }

  void _titleTextSubmitted() {
    widget.titleFormFilled(titleController.text);
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
              widget.labelTitle,
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 6,
            ),
            RegularTextField(
              widget.hintText,
              (value) {
                _titleTextSubmitted();
                //  FocusScope.of(context).unfocus();
              },
              TextInputType.emailAddress,
              titleController,
              theme == ThemeMode.dark,
              autofocus: false,
            ),
            Container(
              height: 14,
            ),
            Text(
              'Details',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 6,
            ),
            MultilineTextField(
                submitForm: _multilineFormSubmitted,
                height: 122,
                hintText: "Task Description"),
            Container(
              height: 14,
            ),
          ],
        ),
      );
    });
  }
}
