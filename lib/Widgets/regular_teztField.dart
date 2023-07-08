import 'package:flutter/material.dart';

import '../Utilities/constants.dart';

class RegularTextField extends StatefulWidget {
  final Function submitForm;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController? editingController;
  final bool isDarkTheme;
  final bool autofocus;
  final FocusNode? focusNode;
  final bool? obscureText;

  const RegularTextField(this.hintText, this.submitForm, this.keyboardType,
      this.editingController, this.isDarkTheme,
      {Key? key, required this.autofocus, this.focusNode, this.obscureText})
      : super(key: key);

  @override
  State<RegularTextField> createState() => _RegularTextFieldState();
}

class _RegularTextFieldState extends State<RegularTextField> {
  var _hintText;
  var _keyboardType;
  var _editingController;
  var _isDarkTheme;
  var _autoFocus;
  var _focusNode;
  var _obscureText;

  @override
  void initState() {
    super.initState();
    _hintText = widget.hintText;
    _keyboardType = widget.keyboardType;
    _editingController = widget.editingController;
    _isDarkTheme = widget.isDarkTheme;
    _autoFocus = widget.autofocus;
    _focusNode = widget.focusNode;

    if (widget.obscureText != null) {
      _obscureText = widget.obscureText;
    } else {
      _obscureText = false;
    }
  }

  void submitForm() {
    final text = _editingController.text;

    widget.submitForm(
      text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      child: TextField(
        autofocus: _autoFocus,
        focusNode: _focusNode,
        obscureText: _obscureText,
        textInputAction: TextInputAction.next,
        keyboardType: _keyboardType,
        cursorColor: _isDarkTheme
            ? Colors.white.withOpacity(0.2)
            : Colors.black.withOpacity(0.2),
        decoration: InputDecoration(
          filled: true,
          fillColor:
              _isDarkTheme ? Colors.black.withOpacity(0.2) : Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _isDarkTheme
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: _isDarkTheme
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: _isDarkTheme
                  ? Colors.transparent
                  : Colors.black.withOpacity(0.2),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          hintText: _hintText,
          hintStyle: TextStyle(
              color: _isDarkTheme
                  ? Colors.white.withOpacity(0.2)
                  : Colors.black.withOpacity(0.2)),
          contentPadding: const EdgeInsets.only(left: 20.0),
        ),
        style: _isDarkTheme
            ? Constants.roboto15DarkThemeTextStyle
            : Constants.roboto15LightThemeTextStyle,
        controller: _editingController,
        onEditingComplete: () => submitForm(),
        onSubmitted: (value) => submitForm(),
        onChanged: (value) => submitForm(),
      
      ),
    );
  }
}

class Inputor {
  int id;
  String initialText;
  String? prefilledText;
  TextEditingController editingController;
  Inputor(this.id, this.initialText, this.prefilledText)
      : editingController = TextEditingController(text: prefilledText);
  String get textValue => editingController.text;
}
