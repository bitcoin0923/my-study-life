import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import '../../Models/Services/storage_service.dart';
import '../Widgets/ProfileWidgets/select_reminder_before.dart';
import '../Models/API/notification_setting.dart';
import '../Widgets/switch_row_spaceAround.dart';
import '../../Models/subjects_datasource.dart';

class ReminderNotificationsScreen extends StatefulWidget {
  const ReminderNotificationsScreen({super.key});

  @override
  State<ReminderNotificationsScreen> createState() =>
      _ReminderNotificationsScreenState();
}

class _ReminderNotificationsScreenState
    extends State<ReminderNotificationsScreen> {
  final ScrollController scrollcontroller = ScrollController();
  final StorageService _storageService = StorageService();
  bool classReminders = false;
  bool xtraReminders = false;
  bool allReminders = false;

  void _switchChangedState(bool isOn, int index) {
    setState(() {
      if (index == 0) {
        allReminders = isOn;
      }
      if (index == 3) {
        classReminders = isOn;
      }
      if (index == 6) {
        xtraReminders = isOn;
      }
      print("Swithc isOn : $isOn");
    });
  }

  void _remindClassBeforeSelected(ClassTagItem type) {
    // print("Selected repetitionMode: ${type.title}");
  }

  void _remindXtraBeforeSelected(ClassTagItem type) {
    // print("Selected repetitionMode: ${type.title}");
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Scaffold(
        backgroundColor: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        extendBodyBehindAppBar: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          foregroundColor: Colors.blue,
          elevation: 0.0,
          title: Text(
            "Reminder Notifications",
            style: TextStyle(
                fontSize: 17,
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500,
                color: theme == ThemeMode.light ? Colors.black : Colors.white),
          ),
        ),
        body: ListView.builder(
          controller: scrollcontroller,
          padding: const EdgeInsets.only(top: 30),
          itemCount: allReminders ? 7 : 1,
          itemBuilder: (context, index) {
            return Column(
              children: [
                if (index == 0) ...[
                  RowSwitchSpaceAround(
                    title: "Reminders",
                    isOn: allReminders,
                    changedState: _switchChangedState,
                    index: index,
                    bottomBorderOn: true,
                  )
                ],
                if (index == 1) ...[
                  RowSwitchSpaceAround(
                    title: "Sound",
                    isOn: true,
                    changedState: _switchChangedState,
                    index: index,
                    bottomBorderOn: true,
                  )
                ],
                if (index == 2) ...[
                  RowSwitchSpaceAround(
                    title: "Vibrate",
                    isOn: true,
                    changedState: _switchChangedState,
                    index: index,
                    bottomBorderOn: true,
                  )
                ],
                if (index == 3) ...[
                  if (classReminders) ...[
                    RowSwitchSpaceAround(
                      title: "Class Reminders",
                      isOn: classReminders,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: false,
                    ),
                    Container(
                      height: 30,
                    ),
                    SelectReminderBefore(
                        reminderSelected: _remindClassBeforeSelected),
                    Container(
                      height: 20,
                    ),
                  ],
                  if (!classReminders) ...[
                    RowSwitchSpaceAround(
                      title: "Class Reminders",
                      isOn: classReminders,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: true,
                    )
                  ],
                ],
                if (index == 4) ...[
                  RowSwitchSpaceAround(
                    title: "Exams Reminders",
                    isOn: true,
                    changedState: _switchChangedState,
                    index: index,
                    bottomBorderOn: true,
                  )
                ],
                if (index == 5) ...[
                  RowSwitchSpaceAround(
                    title: "Task Reminders",
                    isOn: true,
                    changedState: _switchChangedState,
                    index: index,
                    bottomBorderOn: false,
                  ),
                  Container(
                    height: 19,
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              color: theme == ThemeMode.light
                                  ? Constants.lightThemeTextSelectionColor
                                  : Colors.white),
                        ),
                        const Spacer(),
                        Text(
                          "6:00PM",
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'Roboto',
                              fontWeight: FontWeight.normal,
                              color: theme == ThemeMode.light
                                  ? Constants.lightThemeTextSelectionColor
                                  : Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 19,
                  ),
                ],
                if (index == 6) ...[
                  if (xtraReminders) ...[
                    RowSwitchSpaceAround(
                      title: "Xtra Reminders",
                      isOn: xtraReminders,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: false,
                    ),
                    Container(
                      height: 30,
                    ),
                    SelectReminderBefore(
                        reminderSelected: _remindXtraBeforeSelected),
                    Container(
                      height: 20,
                    ),
                  ],
                  if (!xtraReminders) ...[
                    RowSwitchSpaceAround(
                      title: "Xtra Reminders",
                      isOn: xtraReminders,
                      changedState: _switchChangedState,
                      index: index,
                      bottomBorderOn: true,
                    )
                  ],
                ],
              ],
            );
          },
        ),
      );
    });
  }
}
