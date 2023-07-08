import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../app.dart';
import '../../Utilities/constants.dart';
import './holiday_text_imputs.dart';
import '../ClassWidgets/select_dates.dart';
import '../add_photo_widget.dart';
import '../../Models/API/holiday.dart';
import '../../Widgets/custom_snack_bar.dart';
import '.././rounded_elevated_button.dart';

class CreateHoliday extends StatefulWidget {
  final Function saveHoliday;
  final Holiday? holidayItem;
  const CreateHoliday({super.key, required this.saveHoliday, this.holidayItem});

  @override
  State<CreateHoliday> createState() => _CreateHolidayState();
}

class _CreateHolidayState extends State<CreateHoliday> {
  final ScrollController scrollcontroller = ScrollController();

  late Holiday newHoliday = Holiday();
  bool isEditing = false;

  @override
  void initState() {
    checkForEditedHoliday();
    super.initState();
  }

   void checkForEditedHoliday() {
    if (widget.holidayItem != null) {
      isEditing = true;
      newHoliday = widget.holidayItem!;
    }
  }

  void _textInputAdded(String input) {
    newHoliday.title = input;
  }

  void _selectedDates(DateTime pickedDate, bool isDateFrom) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
    if (isDateFrom) {
      newHoliday.startDate = formattedDate;
    } else {
      newHoliday.endDate = formattedDate;
    }
  }

  void _photoAdded(String path) {
   // newHoliday.imageUrl = path;
    newHoliday.newImagePath = path;
  }

  void _saveHoliday() {
    widget.saveHoliday(newHoliday);
  }

  void _cancel() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        color: theme == ThemeMode.light
            ? Constants.lightThemeBackgroundColor
            : Constants.darkThemeBackgroundColor,
        child: ListView.builder(
            controller: scrollcontroller,
            padding: const EdgeInsets.only(top: 30),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  if (index == 0) ...[
                    HolidayTextImputs(
                      holidayName: isEditing ? newHoliday.title : null,
                      formsFilled: _textInputAdded,
                      hintText: 'Holiday Name',
                      labelTitle: 'Name*',
                    )
                  ],
                  if (index == 1) ...[
                    SelectDates(
                      holidayItem: isEditing ? newHoliday : null,
                      dateSelected: _selectedDates,
                      shouldDisableEndDate: false,
                    ),
                  ],
                  if (index == 2) ...[
                    AddPhotoWidget(
                      imageUrl: newHoliday.newImagePath ?? newHoliday.imageUrl,
                      photoAdded: _photoAdded,
                    )
                  ],
                  if (index == 3) ...[
                    // Save/Cancel buttons
                    Container(
                      height: 68,
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      width: double.infinity,
                      // margin: const EdgeInsets.only(top: 260),
                      padding: const EdgeInsets.only(left: 106, right: 106),
                      child: Column(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RoundedElevatedButton(
                              _saveHoliday,
                              "Save Holiday",
                              Constants.lightThemePrimaryColor,
                              Colors.black,
                              45),
                          RoundedElevatedButton(
                              _cancel,
                              "Cancel",
                              Constants.blueButtonBackgroundColor,
                              Colors.white,
                              45)
                        ],
                      ),
                    ),
                    Container(
                      height: 88,
                    ),
                  ],
                ],
              );
            }),
      );
    });
  }
}
