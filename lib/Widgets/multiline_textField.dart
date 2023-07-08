import 'package:flutter/material.dart';

import '../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';

class MultilineTextField extends StatelessWidget {
  final textController = TextEditingController();
  final Function submitForm;
  final double height;
  final String hintText;

  String? prefilledText;
  TextEditingController editingController;

  MultilineTextField(
      {super.key,
      required this.submitForm,
      required this.height,
      this.prefilledText,
      required this.hintText})
      : editingController = TextEditingController(text: prefilledText);

  void _submitForm() {
    final text = editingController.text;

    submitForm(
      text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);

      return Container(
        // margin: EdgeInsets.only(top: distanceFromTop, left: 16, right: 16),
        height: height,
        child: TextField(
          keyboardType: TextInputType.multiline,
          scrollPadding: const EdgeInsets.only(bottom: 40),
          cursorColor: theme == ThemeMode.dark
              ? Colors.white.withOpacity(0.2)
              : Colors.black.withOpacity(0.2),
          decoration: InputDecoration(
            filled: true,
            fillColor: theme == ThemeMode.dark
                ? Colors.black.withOpacity(0.2)
                : Colors.transparent,
               enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme == ThemeMode.dark
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
              focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme == ThemeMode.dark
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: theme == ThemeMode.dark
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
            hintText: hintText,
            hintStyle: TextStyle(
              color: theme == ThemeMode.dark
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2),
            ),
            contentPadding: const EdgeInsets.all(20.0),
          ),
          maxLines: 50,
          style: theme == ThemeMode.dark
            ? Constants.roboto15DarkThemeTextStyle
            : Constants.roboto15LightThemeTextStyle,
          controller: editingController,
          // onSubmitted: (value) => submitForm(),
          onChanged: (value) => _submitForm(),
        ),
      );
    });
  }
}
