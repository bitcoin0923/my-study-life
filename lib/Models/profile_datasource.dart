import 'package:flutter/material.dart';

class ProfileItemStatic {
  final String title;

  ProfileItemStatic({required this.title});

  static List<ProfileItemStatic> personalizationItems = [
    ProfileItemStatic(title: "Manage Subjects"),
    ProfileItemStatic(title: "Personalize"),
    ProfileItemStatic(title: "General"),
    ProfileItemStatic(title: "Reminder Notifications"),
    ProfileItemStatic(title: "Premium Subscription")
  ];

  static List<ProfileItemStatic> editItems = [
    ProfileItemStatic(title: "Change Email"),
    ProfileItemStatic(title: "Change Password"),
  ];
}

class CountryPickerData {
  final String title;
  CountryPickerData({required this.title});

    static List<CountryPickerData> countries = [
    CountryPickerData(title: "United Kingdom"),
    CountryPickerData(title: "United States"),
  ];

}
