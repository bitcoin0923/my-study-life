import 'package:intl/intl.dart';

class NotificationSetting {
  bool? allReminders;
  bool? sound;
  bool? vibrate;
  bool? classReminders;
  String? classRemindBefore;
  bool? examReminders;
  bool? taskReminders;
  bool? xtraReminders;
  String? xtraRemindBefore;

  NotificationSetting(
      {this.allReminders,
      this.sound,
      this.vibrate,
      this.classReminders,
      this.classRemindBefore,
      this.examReminders,
      this.taskReminders,
      this.xtraReminders,
      this.xtraRemindBefore});

  factory NotificationSetting.fromJson(Map<String, dynamic> json) {
    return NotificationSetting(
        allReminders: json['allReminders'],
        sound: json['sound'],
        vibrate: json['vibrate'],
        classReminders: json['classReminders'],
        examReminders: json['examReminders'],
        taskReminders: json['taskReminders'],
        xtraReminders: json['xtraReminders'],
        xtraRemindBefore: json['xtraRemindBefore']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['allReminders'] = allReminders;
    data['sound'] = sound;
    data['vibrate'] = vibrate;
    data['classReminders'] = classReminders;
    data['examReminders'] = examReminders;
    data['taskReminders'] = taskReminders;
    data['xtraReminders'] = xtraReminders;
    data['xtraRemindBefore'] = xtraRemindBefore;

    return data;
  }
}
