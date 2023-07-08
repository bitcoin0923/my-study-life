import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../Utilities/constants.dart';

import '../../app.dart';
import './custom_painter_class.dart';

class CustomDialogBox extends StatefulWidget {
  const CustomDialogBox({Key? key}) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (_, WidgetRef ref, __) {
        final theme = ref.watch(themeModeProvider);
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          child: contentBox(context),
        );
      },
    );
  }

  contentBox(context) {
    return Container(
      height: 254,
     // margin: EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Stack(
        children: <Widget>[
          Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(top: 30),
            child: const Text(
              "Calendar Legend",
              style: TextStyle(
                  fontSize: 17,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 20, right: 20, top: 60),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 33,
                      width: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Container(
                          //alignment: Alignment.topLeft,
                          margin: const EdgeInsets.only(top: 5, left: 5),
                          height: 14,
                          width: 14,
                          decoration: BoxDecoration(
                            color: Constants.calendarLegendClassBlueColor,
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 12),
                      child: const Text(
                        "Class",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      width: 50,
                    ),
                    Container(
                      height: 33,
                      width: 44,
                      decoration: BoxDecoration(
                        color: Constants.calendarLegendExamColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                            color: Constants.calendarLegendClassBlueColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "EXAM",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: const Text(
                        "Exam",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                //2nd row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      height: 18,
                      width: 44,
                      decoration: BoxDecoration(
                        color: Constants.lightThemeTextSelectionColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Center(
                        child: Text(
                          "Due",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: const Text(
                        "Tasks Due",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      width: 25,
                    ),
                    ClipRect(
                      child: Container(
                        height: 22,
                        width: 44,
                        color: Colors.transparent,
                        child: StripsWidget(
                          color1: Constants.diagonalColorPainter,
                          color2: Colors.white,
                          gap: 8,
                          noOfStrips: 10,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: const Text(
                        "Break",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
                //3rd row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Constants.calendarLegendClassBlueColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Container(
                        margin: const EdgeInsetsDirectional.only(top: 4),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 2.0,
                                spreadRadius: 1.0,
                              ),
                            ]),
                        child: Stack(
                          children: [
                            Container(
                              alignment: Alignment.topCenter,
                              margin: const EdgeInsets.all(10),
                              child: Text(
                                "Prep",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Roboto',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 12),
                      child: const Text(
                        "Prep Time",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                    Container(
                      width: 29,
                    ),
                    Container(
                      height: 33,
                      width: 44,
                     // margin: EdgeInsets.only(bottom: 20),
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey, width: 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 2.0,
                            spreadRadius: 1.0,
                          ),
                        ],
                      ),
                      child: Image.asset('assets/images/EventBlueIcon.png'),
                    ),
                    // Container(
                    //   width: 30,
                    // ),
                    Container(
                      margin: const EdgeInsets.only(left: 14),
                      child: const Text(
                        "Events",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
