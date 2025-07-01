enum TabsItemType { app, browser }

interface class TabsItem {
  int id;
  TabsItemType type;

  String title;
  List<String> tagList;

  TabsItem({
    required this.id,
    required this.type,
    required this.title,
    this.tagList = const [],
  });
}
