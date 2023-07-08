import 'package:flutter/material.dart';

enum HolidayType {
   holiday, extra,
}

class HolidayItem {
  final String title;
  final DateTime dateFrom;
  final HolidayType type;
  DateTime? dateTo;
  String? holidayImage;
  String? holidayImageBig;

  HolidayItem( 
      {required this.title,
      required this.type, 
      required this.dateFrom,
      this.dateTo,
      this.holidayImage,
      this.holidayImageBig,});

  static List<HolidayItem> holidays = [
    HolidayItem(dateFrom: DateTime.now(), type: HolidayType.holiday, title: "Doctor's appointment"),
    HolidayItem(
      type: HolidayType.holiday,
      title: 'Trekking trip to Yosemite as planned with Mike in Dec',
      dateFrom: DateTime.now().add(const Duration(days: 1)),
      dateTo: DateTime.now().add(const Duration(days: 2)),
      holidayImage: 'assets/images/MountainHolidayImage.png',
      holidayImageBig: 'assets/images/HolidayBigBackground.png'
    ),
    HolidayItem(
      type: HolidayType.holiday,
        dateFrom: DateTime.now().add(const Duration(days: 10)),
        title: "Training Day"),
    HolidayItem(
      type: HolidayType.holiday,
      title: 'Family Meet',
      dateFrom: DateTime.now().add(const Duration(days: 12)),
      dateTo: DateTime.now().add(const Duration(days: 15)),
      holidayImage: 'assets/images/MountainHolidayImage.png',
      holidayImageBig: 'assets/images/HolidayBigBackground.png'
    ),
  ];

   static List<HolidayItem> extras = [
    HolidayItem(type: HolidayType.extra, dateFrom: DateTime.now(), title: "Free class"),
    HolidayItem(
      type: HolidayType.extra,
      title: 'Lunch Break',
      dateFrom: DateTime.now().add(const Duration(days: 1)),
      dateTo: DateTime.now().add(const Duration(days: 2)),
      holidayImage: 'assets/images/MountainHolidayImage.png',
      holidayImageBig: 'assets/images/HolidayBigBackground.png'
    ),
  ];
}
