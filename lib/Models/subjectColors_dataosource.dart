import 'package:flutter/material.dart';

class SubjectColor {
  bool selected;
  final Color itemColor;

  SubjectColor(
    this.itemColor, {
    required this.selected,
  });

  static List<SubjectColor> subjectColors = [
    SubjectColor(Colors.red, selected: false),
    SubjectColor(Colors.green, selected: false),
    SubjectColor(Colors.blue, selected: false),
    SubjectColor(Colors.purple, selected: false),
    SubjectColor(Colors.yellow, selected: false),
    SubjectColor(Colors.orange, selected: false),
    SubjectColor(Colors.grey, selected: false),
  ];
}

class SubjectPhoto {
  bool selected;
  bool isLocked;
  final String? imagePath;

  SubjectPhoto(
    this.imagePath, {
    required this.isLocked,
    required this.selected,
  });

  static List<SubjectPhoto> subjectPhotos = [
    SubjectPhoto("assets/images/ClassExamBackgroundImage.png", selected: false, isLocked: false),
    SubjectPhoto("assets/images/ClassExamBackgroundImage.png", selected: false, isLocked: true),
    SubjectPhoto("assets/images/ClassExamBackgroundImage.png", selected: false, isLocked: true),
    SubjectPhoto("assets/images/ClassExamBackgroundImage.png", selected: false, isLocked: false),
    SubjectPhoto("assets/images/ClassExamBackgroundImage.png", selected: false, isLocked: false),
    SubjectPhoto("assets/images/ClassExamBackgroundImage.png", selected: false, isLocked: false),
    SubjectPhoto("assets/images/ClassExamBackgroundImage.png", selected: false, isLocked: false),
    SubjectPhoto("assets/images/ClassExamBackgroundImage.png", selected: false, isLocked: false),
  ];
}
