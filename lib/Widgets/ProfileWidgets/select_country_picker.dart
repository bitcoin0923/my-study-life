import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../app.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import '../../Utilities/constants.dart';
import '../../Models/profile_datasource.dart';

class SelectCountryPicker extends StatefulWidget {
  final Function countrySelected;
  const SelectCountryPicker({super.key, required this.countrySelected});

  @override
  State<SelectCountryPicker> createState() => _SelectCountryPickerState();
}

class _SelectCountryPickerState extends State<SelectCountryPicker> {
  final List<CountryPickerData> countries = CountryPickerData.countries;

  String selectedCountry = CountryPickerData.countries.first.title;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (_, WidgetRef ref, __) {
      final theme = ref.watch(themeModeProvider);
      return Container(
        height: 115,
        width: double.infinity,
        margin: EdgeInsets.only(left: 22, right: 22),
        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            Text(
              "Which country are you from?",
              textAlign: TextAlign.left,

              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.bold,
                  color:
                      theme == ThemeMode.light ? Colors.black : Colors.white),
            ),
            Container(
              height: 7,
            ),
            Expanded(
              child: Text(
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                "If you want to, let us know where you are from so that we can suggest you the most relevant personalization",
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.normal,
                  color: theme == ThemeMode.light
                      ? Colors.black.withOpacity(0.7)
                      : Colors.white.withOpacity(0.7),
                ),
              ),
            ),
            // Container(
            //   height: 15,
            // ),
            Container(
              height: 45,
              width: double.infinity,
              //margin: const EdgeInsets.only(left: 40, right: 40),
              decoration: BoxDecoration(
                color: theme == ThemeMode.light
                    ? Colors.transparent
                    : Colors.black,
                border: Border.all(
                  width: 1,
                  color: theme == ThemeMode.dark
                      ? Colors.transparent
                      : Colors.black.withOpacity(0.2),
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              child: DropdownButtonHideUnderline(
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    value: selectedCountry,
                    onChanged: (String? newValue) => setState(() {
                       widget.countrySelected(newValue);
                       selectedCountry = newValue ?? "";
                    }),
                    // setState(() => selectedDuration = newValue ?? ""),
                    items: countries
                        .map<DropdownMenuItem<String>>(
                            (CountryPickerData durationItem) =>
                                DropdownMenuItem<String>(
                                  value: durationItem.title,
                                  child: Text(durationItem.title),
                                ))
                        .toList(),
                    icon: const Icon(Icons.keyboard_arrow_down),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
