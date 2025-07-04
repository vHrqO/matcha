import 'package:flutter/material.dart';
import 'package:matcha/mock_data/browser_window.dart';
import 'package:matcha/model/browser_window.dart';
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/mock_data/session_list.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/app/constants.dart';

import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;

part 'opened_tabs_card_viewmodel.g.dart';

// WindowList
// tabList
@riverpod
class WindowList extends _$WindowList {
  late List<BrowserWindow> _windowList;

  @override
  bool updateShouldNotify(
    AsyncValue<List<BrowserWindow>> previous,
    AsyncValue<List<BrowserWindow>> next,
  ) {
    // TODO: implement updateShouldNotify
    return true;
  }

  @override
  Future<List<BrowserWindow>> build() async {
    // from browser , api service
    // convert from api return object
    // mockWindow1
    _windowList = mockWindowList;

    return _windowList;
  }

  Future<void> removeWindow(int windowId) async {
    //
    _windowList.removeWhere((window) {
      return window.id == windowId;
    });

    //


    ref.invalidateSelf();
  }
}

//
@riverpod
class Window extends _$Window {
  late BrowserWindow _window;

  @override
  bool updateShouldNotify(
    AsyncValue<BrowserWindow> previous,
    AsyncValue<BrowserWindow> next,
  ) {
    //
    return true;
  }

  @override
  Future<BrowserWindow> build(int windowId) async {
    final windowList = await ref.watch(windowListProvider.future);

    _window = windowList.firstWhere(
      (window) => window.id == windowId,
      orElse: () => throw Exception('Window not found'),
    );

    return _window;
  }

  Future<void> removeTabsItem(TabsItem tabsItem) async {
    // use api service to remove tab
    // use api service to remove tab group
    
    print(tabsItem is matcha_tab.Tab);
    if (tabsItem is matcha_tab.Tab && tabsItem.groupId != null) {
      print("here");

      // remove tab from group
      final group = _window.tabsItemList.firstWhere(
        (item) => item.id == tabsItem.groupId,
        orElse: () => throw Exception('Tab group not found'),
      );

      if (group is matcha_tab_group.TabGroup) {
        group.tabList.removeWhere((tab) => tab.id == tabsItem.id);
      } else {
        throw Exception('Expected TabGroup but found ${group.runtimeType}');
      }
    } else {
      //
      _window.tabsItemList.removeWhere((item) {
        return item.id == tabsItem.id;
      });
    }

    //


    ref.invalidateSelf();
  }
}
