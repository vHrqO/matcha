import 'package:matcha/model/session/session.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/model/tabs_item/tabs_item.dart';

//
final mockSession = Session(
  id: 0,
  name: 'Session Name',

  tabsItemList: [
    matcha_tab.Tab(
      id: 0,

      type: TabsItemType.app,
      title: "Tab Title",
      url: "https://example.com",
    ),
    matcha_tab.Tab(
      id: 1,

      type: TabsItemType.app,
      title: "Tab Title",
      url: "https://example.com",
      tagList: ['tag1', 'tag2'],
    ),
  ],
);

//
final mockSession1 = Session(
  id: 1,
  name: 'flutter',

  //
  tabsItemList: [
    matcha_tab.Tab(
      id: 0,

      type: TabsItemType.app,
      title: "How To Use Style · Sub6Resources/flutter_html Wiki",
      url: "https://github.com/Sub6Resources/flutter_html/wiki/How-To-Use-Style",
    ),
    matcha_tab.Tab(
      id: 1,

      type: TabsItemType.app,
      title: 'flutter_animate | Flutter package',
      url: 'https://pub.dev/packages/flutter_animate',
      tagList: ['flutter', 'animation'],
    ),

    // group
    matcha_tab_group.TabGroup(
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
        ),
        matcha_tab.Tab(
          id: 4,
          groupId: 2,
          type: TabsItemType.app,
          title:
              'objectbox/objectbox-dart: Flutter database for super-fast Dart object persistence',
          url: 'https://github.com/objectbox/objectbox-dart',
          tagList: ['flutter'],
        ),
      ],
    ),

    //
    matcha_tab.Tab(
      id: 5,
      type: TabsItemType.app,
      title: 'c++ - What exactly is std::atomic? - Stack Overflow',
      url: 'https://stackoverflow.com/questions/31978324/what-exactly-is-stdatomic',
      tagList: ['c++'],
    ),

    // group
    matcha_tab_group.TabGroup(
      id: 6,
      type: TabsItemType.app,

      title: 'documentation ',
      tagList: ['flutter', 'documentation '],
      tabList: [
        matcha_tab.Tab(
          id: 7,
          groupId: 6,
          type: TabsItemType.app,
          title: "Flutter documentation | Flutter",
          url: "https://docs.flutter.dev/",
          tagList: ['flutter'],
        ),
        matcha_tab.Tab(
          id: 8,
          groupId: 6,
          type: TabsItemType.app,
          title: 'Flutter 开发文档 - Flutter 中文文档 - Flutter 中文开发者网站 - Flutter',
          url: 'https://flutter.cn/docs',
          tagList: ['flutter'],
        ),
      ],
    ),

    //same
    matcha_tab.Tab(
      id: 9,
      type: TabsItemType.app,
      title: "How To Use Style · Sub6Resources/flutter_html Wiki",
      url: "https://github.com/Sub6Resources/flutter_html/wiki/How-To-Use-Style",
    ),
    matcha_tab.Tab(
      id: 10,
      type: TabsItemType.app,
      title: 'flutter_animate | Flutter package',
      url: 'https://pub.dev/packages/flutter_animate',
      tagList: ['flutter', 'animation'],
    ),

    // group
    matcha_tab_group.TabGroup(
      id: 11,
      type: TabsItemType.app,
      title: 'Z Flutter package',
      tagList: ['flutter', 'package'],
      tabList: [
        matcha_tab.Tab(
          id: 12,
          groupId: 11,
          type: TabsItemType.app,
          title: "flutter_quill | Flutter package",
          url: "https://pub.dev/packages/flutter_quill",
        ),
        matcha_tab.Tab(
          id: 13,
          groupId: 11,
          type: TabsItemType.app,
          title:
              'objectbox/objectbox-dart: Flutter database for super-fast Dart object persistence',
          url: 'https://github.com/objectbox/objectbox-dart',
          tagList: ['flutter'],
        ),
      ],
    ),

    //
    matcha_tab.Tab(
      id: 14,
      type: TabsItemType.app,
      title: 'V c++ - What exactly is std::atomic? - Stack Overflow',
      url: 'https://stackoverflow.com/questions/31978324/what-exactly-is-stdatomic',
      tagList: ['c++'],
    ),

    // group
    matcha_tab_group.TabGroup(
      id: 15,
      type: TabsItemType.app,
      title: 'X documentation ',
      tagList: ['flutter', 'documentation '],
      tabList: [
        matcha_tab.Tab(
          id: 16,
          groupId: 15,
          type: TabsItemType.app,
          title: "Flutter documentation | Flutter",
          url: "https://docs.flutter.dev/",
          tagList: ['flutter'],
        ),
        matcha_tab.Tab(
          id: 17,
          groupId: 15,
          type: TabsItemType.app,
          title: 'Flutter 开发文档 - Flutter 中文文档 - Flutter 中文开发者网站 - Flutter',
          url: 'https://flutter.cn/docs',
          tagList: ['flutter'],
        ),
      ],
    ),
  ],
);

//
final mockSession2 = Session(
  id: 2,
  name: 'Rust documentation',

  //
  tabsItemList: [
    matcha_tab.Tab(
      id: 18,
      type: TabsItemType.app,
      title: "The Rust Programming Language - The Rust Programming Language",
      url: "https://doc.rust-lang.org/book/",
      tagList: ['rust', 'documentation'],
    ),
    matcha_tab.Tab(
      id: 19,
      type: TabsItemType.app,
      title: 'Rust 程式設計語言 - Rust 程式設計語言',
      url: 'https://rust-lang.tw/book-tw/',
      tagList: ['rust', 'documentation'],
    ),

    //
    matcha_tab.Tab(
      id: 20,
      type: TabsItemType.app,
      title: 'c++ - What exactly is std::atomic? - Stack Overflow',
      url: 'https://stackoverflow.com/questions/31978324/what-exactly-is-stdatomic',
      tagList: ['c++'],
    ),

    // group
    matcha_tab_group.TabGroup(
      id: 21,
      type: TabsItemType.app,
      title: 'documentation ',
      tagList: ['flutter', 'documentation '],
      tabList: [
        matcha_tab.Tab(
          id: 22,
          groupId: 21,
          type: TabsItemType.app,
          title: "Flutter documentation | Flutter",
          url: "https://docs.flutter.dev/",
          tagList: ['flutter'],
        ),
        matcha_tab.Tab(
          id: 23,
          groupId: 21,
          type: TabsItemType.app,
          title: 'Flutter 开发文档 - Flutter 中文文档 - Flutter 中文开发者网站 - Flutter',
          url: 'https://flutter.cn/docs',
          tagList: ['flutter'],
        ),
      ],
    ),
  ],
);

final mockSession3 = Session(
  id: 3,
  name: 'Z Session',

  tabsItemList: [
    matcha_tab.Tab(
      id: 24,
      type: TabsItemType.app,
      title: "Tab Title",
      url: "https://example.com",
    ),
    matcha_tab.Tab(
      id: 25,
      type: TabsItemType.app,
      title: "Tab Title",
      url: "https://example.com",
      tagList: ['tag1', 'tag2'],
    ),
  ],
);
