import 'package:flutter/material.dart';

class TabItem {
  final String name;
  Widget icon;
  Widget activeIcon;
  Widget iconDark;
  Widget activeDarkIcon;
  int index;

  TabItem(
      {required this.name,
      required this.icon,
      required this.activeIcon,
      required this.iconDark,
      required this.activeDarkIcon,
      required this.index});

  static List<TabItem> tabItems = [
    TabItem(
      name: "Home",
      icon: Image.asset('assets/images/HomeIconNormal.png'),
      activeIcon: Image.asset('assets/images/HomeIconSelected.png'),
      index: 0, 
      activeDarkIcon: Image.asset('assets/images/HomeIconDarkSelected.png'), 
      iconDark: Image.asset('assets/images/HomeIconDarkNormal.png'),
    ),
    TabItem(
      name: "Calendar",
      icon: Image.asset('assets/images/CalendarIconNormal.png'),
      activeIcon: Image.asset('assets/images/CalendarIconSelected.png'),
      index: 1,
      activeDarkIcon: Image.asset('assets/images/CalendarIconDarkSelected.png'), 
      iconDark: Image.asset('assets/images/CalendarIconDarkNormal.png'),
    ),
    TabItem(
      name: "",
      icon: const Text(""),
      activeIcon: const Text(""),
      index: 2,
      activeDarkIcon: const Text(""),
      iconDark: const Text(""),
    ),
    TabItem(
      name: "Activities",
      icon: Image.asset('assets/images/ActivitiesIconNormal.png'),
      activeIcon: Image.asset('assets/images/ActivitiesIconSelected.png'),
      index: 3,
      activeDarkIcon: Image.asset('assets/images/ActivitiesIconDarkSelected.png'), 
      iconDark: Image.asset('assets/images/ActivitesIconDarkNormal.png'),
    ),
    TabItem(
      name: "Profile",
      icon: Image.asset('assets/images/ProfileIconNormal.png'),
      activeIcon: Image.asset('assets/images/ProfileIconSelected.png'),
      index: 4,
      activeDarkIcon: Image.asset('assets/images/ProfileIconDarkSelected.png'), 
      iconDark: Image.asset('assets/images/ProfileIconDarkNormal.png'),
    ),
  ];
}
