import 'package:matcha/model/session/session.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/model/tabs_item/tabs_item.dart';

// Mock data for skeletons
final mockSession = Session(
  id: 0,
  name: 'Session Name',

  tabsItemList: [
    matcha_tab.Tab(
      id: 0,

      type: TabsItemType.app,
      title: "Tab Title",
      url: "https://example.com",
      tagList: ['tag1', 'tag2'],
    ),
    matcha_tab.Tab(
      id: 1,

      type: TabsItemType.app,
      title: "Flutter - Dart API docs",
      url: "https://api.flutter.dev/index.html",
      tagList: ['flutter', 'docs'],
    ),
  ],
);

// Mock data for testing
final mockSession1 = Session(
  id: 1,
  name: 'Flutter',

  tabsItemList: [
    matcha_tab.Tab(
      id: 0,

      type: TabsItemType.app,
      title: "Flutter - Dart API docs",
      url: "https://api.flutter.dev/index.html",
      tagList: ['flutter', 'docs'],
    ),
    matcha_tab.Tab(
      id: 1,

      type: TabsItemType.app,
      title: 'flutter_animate | Flutter package',
      url: 'https://pub.dev/packages/flutter_animate',
      tagList: ['flutter', 'docs', 'animation'],
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
    ),

    //
    matcha_tab.Tab(
      id: 5,
      type: TabsItemType.app,
      title: 'Colors class - material library - Dart API',
      url: 'https://api.flutter.dev/flutter/material/Colors-class.html',
      tagList: ['flutter', 'docs', 'themes'],
    ),

    // group
    matcha_tab_group.TabGroup(
      id: 6,
      type: TabsItemType.app,

      title: 'documentation',
      tagList: ['flutter', 'documentation'],
      tabList: [
        matcha_tab.Tab(
          id: 7,
          groupId: 6,
          type: TabsItemType.app,
          title: "Flutter documentation | Flutter",
          url: "https://docs.flutter.dev/",
          tagList: ['flutter', 'docs'],
        ),
        matcha_tab.Tab(
          id: 8,
          groupId: 6,
          type: TabsItemType.app,
          title: 'Animatable class - animation library - Dart API',
          url: 'https://api.flutter.dev/flutter/animation/Animatable-class.html',
          tagList: ['flutter', 'docs', 'animation'],
        ),
      ],
    ),

    //
    matcha_tab.Tab(
      id: 9,
      type: TabsItemType.app,
      title: "Row class - widgets library - Dart API",
      url: "https://api.flutter.dev/flutter/widgets/Row-class.html",
      tagList: ['flutter', 'docs', 'flex'],
    ),
    matcha_tab.Tab(
      id: 10,
      type: TabsItemType.app,
      title: 'Column class - widgets library - Dart API',
      url: 'https://api.flutter.dev/flutter/widgets/Column-class.html',
      tagList: ['flutter', 'docs', 'flex'],
    ),
  ],
);

//
final mockSession2 = Session(
  id: 2,
  name: 'Rust , C++',

  //
  tabsItemList: [
    matcha_tab.Tab(
      id: 11,
      type: TabsItemType.app,
      title: "The Rust Programming Language - The Rust Programming Language",
      url: "https://doc.rust-lang.org/book/",
      tagList: ['rust', 'docs'],
    ),
    matcha_tab.Tab(
      id: 12,
      type: TabsItemType.app,
      title: 'Rust 程式設計語言 - Rust 程式設計語言',
      url: 'https://rust-lang.tw/book-tw/',
      tagList: ['rust', 'docs'],
    ),

    //
    matcha_tab.Tab(
      id: 13,
      type: TabsItemType.app,
      title: 'c++ - What exactly is std::atomic? - Stack Overflow',
      url: 'https://stackoverflow.com/questions/31978324/what-exactly-is-stdatomic',
      tagList: ['c++', 'Stack Overflow'],
    ),

    // group
    matcha_tab_group.TabGroup(
      id: 14,
      type: TabsItemType.app,
      title: 'documentation',
      tagList: ['c++', 'rust', 'docs'],
      tabList: [
        matcha_tab.Tab(
          id: 15,
          groupId: 14,
          type: TabsItemType.app,
          title: "std - Rust",
          url: "https://doc.rust-lang.org/std/index.html",
          tagList: ['rust', 'docs'],
        ),
        matcha_tab.Tab(
          id: 16,
          groupId: 14,
          type: TabsItemType.app,
          title: 'cppreference.com',
          url: 'https://en.cppreference.com/index.html',
          tagList: ['c++', 'docs'],
        ),
      ],
    ),
  ],
);
