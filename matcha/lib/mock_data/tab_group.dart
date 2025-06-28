import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;

// Mock data for skeletons
final mockTabGroup = matcha_tab_group.TabGroup(
  id: 2,
  type: TabsItemType.app,

  title: 'Flutter package',
  tagList: ['flutter', 'package'],
  tabList: [
    matcha_tab.Tab(
      id: 3,
      groupId: 2,
      type: TabsItemType.app,
      title: "flutter_quill | Flutter package",
      url: "https://pub.dev/packages/flutter_quill",
      tagList: ['flutter', 'docs'],
    ),
    matcha_tab.Tab(
      id: 4,
      groupId: 2,
      type: TabsItemType.app,
      title: 'drift | Dart package',
      url: 'https://pub.dev/packages/drift',
      tagList: ['flutter', 'docs', 'database'],
    ),
  ],
);
