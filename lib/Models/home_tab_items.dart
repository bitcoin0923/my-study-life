
class HomeTabItem {
  final String title;
   int badgeNumber;
   bool selected;
  final int cardIndex;

  HomeTabItem({
    required this.title,
    required this.badgeNumber,
    required this.selected,
    required this.cardIndex,
  });

  static List<HomeTabItem> tabItems = [
    HomeTabItem(title: "Classes", badgeNumber: 4, selected: true, cardIndex: 0),
    HomeTabItem(title: "Exams", badgeNumber: 5, selected: false, cardIndex: 1),
    HomeTabItem(
        title: "Tasks Due", badgeNumber: 12, selected: false, cardIndex: 2)
  ];
}
