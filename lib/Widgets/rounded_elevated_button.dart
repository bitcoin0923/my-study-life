import 'package:flutter/material.dart';

class RoundedElevatedButton extends StatelessWidget {
  final VoidCallback selectHandler;
  final String buttonTitle;
  final Color buttonBackgroundColor;
  final Color buttonTitleColor;
  final double height;

  const RoundedElevatedButton(this.selectHandler, this.buttonTitle,
      this.buttonBackgroundColor, this.buttonTitleColor, this.height,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(top: 4, bottom: 4),
      child: ElevatedButton(
          style: ButtonStyle(
              elevation: MaterialStateProperty.all(0.0),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              )),
              minimumSize: MaterialStateProperty.all(
                  const Size((double.infinity - 80), 45)),
              backgroundColor: MaterialStateProperty.all(buttonBackgroundColor),
              foregroundColor:  MaterialStateProperty.all(buttonTitleColor),
              textStyle: MaterialStateProperty.all(TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: buttonTitleColor))),
          onPressed: selectHandler,
          child: Text(buttonTitle)),
    );
  }
}
