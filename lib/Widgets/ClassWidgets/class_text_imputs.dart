import 'package:flutter/material.dart';

import '../../Utilities/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Extensions/extensions.dart';
import '../regular_teztField.dart';
import '../../app.dart';
import '../../Models/subjects_datasource.dart';
import '../../Models/API/classmodel.dart';

enum TextFieldType {
  moduleName, roomName, buildingName, teacherName, onlineURL, techerEmail, seatName, 
}

class ClassTextImputs extends StatefulWidget {
  final Function textInputAdded;
  final bool isClassInPerson;
  final ClassModel? classItem;
  const ClassTextImputs(
      {super.key,
      required this.textInputAdded,
      required this.isClassInPerson, this.classItem});

  @override
  State<ClassTextImputs> createState() => _ClassTextImputsState();
}

class _ClassTextImputsState extends State<ClassTextImputs> {
  final moduleNameController = TextEditingController();
  final roomNameController = TextEditingController();
  final buildingNameController = TextEditingController();
  final teacherNameController = TextEditingController();
  final onlineUrlController = TextEditingController();
  final teachersEmailController = TextEditingController();

  int selectedTabIndex = 0;

  void _submitForm(String text, TextFieldType type) {
         widget.textInputAdded(text, type);
  }

  @override
  void initState() {
    if (widget.classItem != null) {
      moduleNameController.text = widget.classItem?.module ?? "";
      roomNameController.text = widget.classItem?.room ?? "";
      buildingNameController.text = widget.classItem?.building ?? "";
      teacherNameController.text = widget.classItem?.teacher ?? "";
      onlineUrlController.text = widget.classItem?.onlineUrl ?? "";
      teachersEmailController.text = widget.classItem?.teachersEmail ?? "";
    }
    super.initState();
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
              'Module',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 6,
            ),
            RegularTextField("Module Name", (value) {
              _submitForm(moduleNameController.text, TextFieldType.moduleName);
             // FocusScope.of(context).nextFocus();
            }, TextInputType.emailAddress, moduleNameController,
                theme == ThemeMode.dark, autofocus: false,),
            Container(
              height: 14,
            ),
            if (widget.isClassInPerson) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 90,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Room',
                          style: theme == ThemeMode.light
                              ? Constants.lightThemeSubtitleTextStyle
                              : Constants.darkThemeSubtitleTextStyle,
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          height: 6,
                        ),
                        RegularTextField("Room", (value) {
                        _submitForm(roomNameController.text, TextFieldType.roomName);

                         // FocusScope.of(context).nextFocus();
                        }, TextInputType.emailAddress, roomNameController,
                            theme == ThemeMode.dark, autofocus: false,),
                      ],
                    ),
                  ),
                  Container(
                    height: 90,
                    width: 150,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Building',
                          style: theme == ThemeMode.light
                              ? Constants.lightThemeSubtitleTextStyle
                              : Constants.darkThemeSubtitleTextStyle,
                          textAlign: TextAlign.left,
                        ),
                        Container(
                          height: 6,
                        ),
                        RegularTextField("Building", (value) {
                        _submitForm(buildingNameController.text, TextFieldType.buildingName);

                         // FocusScope.of(context).nextFocus();
                        }, TextInputType.emailAddress, buildingNameController,
                            theme == ThemeMode.dark, autofocus: false,),
                      ],
                    ),
                  ),
                  
                ],
              ),
            ],
            if (!widget.isClassInPerson) ...[
              Text(
                'Online URL',
                style: theme == ThemeMode.light
                    ? Constants.lightThemeSubtitleTextStyle
                    : Constants.darkThemeSubtitleTextStyle,
                textAlign: TextAlign.left,
              ),
              Container(
                height: 6,
              ),
              RegularTextField("Online URL", (value) {
                _submitForm(onlineUrlController.text, TextFieldType.onlineURL);
                // FocusScope.of(context).nextFocus();
              }, TextInputType.emailAddress, onlineUrlController,
                  theme == ThemeMode.dark, autofocus: false,),
              Container(
                height: 14,
              ),
            ],
            Text(
              'Teacher',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 6,
            ),
            RegularTextField("Teacher Name", (value) {
              // FocusScope.of(context).nextFocus();
             _submitForm(teacherNameController.text, TextFieldType.teacherName);
            }, TextInputType.name, teacherNameController,
                theme == ThemeMode.dark, autofocus: false,),
            Container(
              height: 14,
            ),
            if (!widget.isClassInPerson) ...[
                Text(
              'Teacher Email',
              style: theme == ThemeMode.light
                  ? Constants.lightThemeSubtitleTextStyle
                  : Constants.darkThemeSubtitleTextStyle,
              textAlign: TextAlign.left,
            ),
            Container(
              height: 6,
            ),
            Container(
              child: RegularTextField("Teacher Email", (value) {
                _submitForm(teachersEmailController.text, TextFieldType.techerEmail);
                // FocusScope.of(context).unfocus();
              }, TextInputType.emailAddress, teachersEmailController,
                  theme == ThemeMode.dark, autofocus: false,),
            ),
            Container(
              height: 14,
            ),
            ],
          ],
        ),
      );
    });
  }
}
