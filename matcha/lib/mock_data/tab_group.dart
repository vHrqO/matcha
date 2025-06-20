import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/model/tabs_item/tabs_item.dart';

final mockTabGroup = matcha_tab_group.TabGroup(
  id: 0,
  type: TabsItemType.app,

  title: 'Flutter package',
  tagList: ['flutter', 'package'],
  tabList: [
    matcha_tab.Tab(
      id: 1,
      groupId: 0,
      type: TabsItemType.app,

      title: "flutter_riverpod | Flutter package",
      url: "https://pub.dev/packages/flutter_riverpod",
      tagList: ['pub', 'flutter'],
    ),
    matcha_tab.Tab(
      id: 2,
      groupId: 0,
      type: TabsItemType.app,

      title:
          "rrousselGit/riverpod: A reactive caching and data-binding framework.   Riverpod makes working with asynchronous code a breeze.",
      url: 'https://github.com/rrousselGit/riverpod',
      tagList: ['github', 'flutter'],
    ),
  ],
);
