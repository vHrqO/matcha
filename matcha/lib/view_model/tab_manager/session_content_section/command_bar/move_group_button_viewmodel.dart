import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/view_model/shared/app_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;

part 'move_group_button_viewmodel.g.dart';

/// MoveToGroup
///
@riverpod
class MoveToGroupButton extends _$MoveToGroupButton {
  bool _enabled = false;

  int _tabCount = 0;
  int _tabGroupCount = 0;

  bool _appTypeOnly = false;
  bool _hasItemInGroup = false;
  bool _tabGroupOpened = false;

  @override
  bool build() {
    ref.watch(selectedTabsItemProvider);
    _tabGroupOpened = ref.watch(tabGroupOpenedProvider);

    _appTypeOnly = ref.read(selectedTabsItemProvider.notifier).isAppTypeOnly();
    _hasItemInGroup = ref.read(selectedTabsItemProvider.notifier).hasItemInGroup();

    _tabCount = ref.read(selectedTabsItemProvider.notifier).getTabCount();
    _tabGroupCount = ref.read(selectedTabsItemProvider.notifier).getTabGroupCount();

    // only when app type and TabGroup is Opened
    if (!_appTypeOnly || !_tabGroupOpened) {
      _enabled = false;
      return _enabled;
    }

    // tab only and not in group
    _enabled = (_tabCount > 0 && _tabGroupCount == 0 && !_hasItemInGroup);

    return _enabled;
  }

  Future<void> move(int sessionId) async {
    if (!_enabled) {
      throw Exception('MoveToGroupButton is not enabled');
    }

    final selectedTabsItem = ref.read(selectedTabsItemProvider);
    final idList = selectedTabsItem.keys.toList();

    List<matcha_tab.Tab> toMoveTabs = [];

    // target group
    final targetGroup = await ref.read(selectedTabGroupProvider.future);
    if (targetGroup == null) {
      throw Exception('No target group selected');
    }

    selectedTabsItem.values.map((item) {
      if (item is matcha_tab.Tab) {
        // change groupId to target group id
        item.groupId = targetGroup.id;

        toMoveTabs.add(item);
      }
    }).toList();

    for (var element in toMoveTabs) {
      await ref
          .read(sessionContentProvider(sessionId).notifier)
          .moveTabInGroup(element, targetGroup.id);
    }

    //------------------------------------------
    // add to group
    // targetGroup.tabList.addAll(toMoveTabs);

    // // remove from session
    // await ref
    //     .read(sessionContentProvider(sessionId).notifier)
    //     .removeAllTabsItem(selectedTabsItem.values.toList());

    // // update  group
    // await ref
    //     .read(sessionContentProvider(sessionId).notifier)
    //     .updateTabsItem(targetGroup);

    //-------------------------------------------

    ref.read(selectedTabsItemProvider.notifier).clearSelected();
  }
}

@riverpod
class MoveToGroupButtonTap extends _$MoveToGroupButtonTap {
  bool _enabled = false;

  bool _tabGroupOpened = false;

  @override
  bool build() {
    _tabGroupOpened = ref.watch(tabGroupOpenedProvider);

    // when TabGroup is Opened
    _enabled = _tabGroupOpened;

    return _enabled;
  }

  Future<void> move(int sessionId, matcha_tab.Tab tab) async {
    final link = ref.keepAlive();

    if (!_enabled) {
      throw Exception('MoveToGroupButtonTap is not enabled');
    }

    // target group
    final targetGroup = await ref.read(selectedTabGroupProvider.future);
    if (targetGroup == null) {
      throw Exception('No target group selected');
    }

    // change groupId to target group id
    tab.groupId = targetGroup.id;

    // add to group
    targetGroup.tabList.add(tab);

    await ref
        .read(sessionContentProvider(sessionId).notifier)
        .moveTabInGroup(tab, targetGroup.id);
    //---
    // // remove from session
    // await ref.read(sessionContentProvider(sessionId).notifier).removeTabsItem(tab);

    // // update  group
    // await ref
    //     .read(sessionContentProvider(sessionId).notifier)
    //     .updateTabsItem(targetGroup);

    link.close();
  }
}

/// MoveOutGroup
///
@riverpod
class MoveOutGroupButton extends _$MoveOutGroupButton {
  bool _enabled = false;

  int _tabCount = 0;
  int _tabGroupCount = 0;

  bool _appTypeOnly = false;
  bool _hasItemInGroup = false;
  bool _hasItemOutGroup = false;
  bool _tabGroupOpened = false;

  @override
  bool build() {
    ref.watch(selectedTabsItemProvider);
    _tabGroupOpened = ref.watch(tabGroupOpenedProvider);

    _appTypeOnly = ref.read(selectedTabsItemProvider.notifier).isAppTypeOnly();
    _hasItemInGroup = ref.read(selectedTabsItemProvider.notifier).hasItemInGroup();
    _hasItemOutGroup = ref.read(selectedTabsItemProvider.notifier).hasItemOutGroup();

    _tabCount = ref.read(selectedTabsItemProvider.notifier).getTabCount();
    _tabGroupCount = ref.read(selectedTabsItemProvider.notifier).getTabGroupCount();

    // only when app type and TabGroup is Opened
    if (!_appTypeOnly || !_tabGroupOpened) {
      _enabled = false;
      return _enabled;
    }

    // tab only and only ItemInGroup
    _enabled =
        (_tabCount > 0 && _tabGroupCount == 0 && _hasItemInGroup && !_hasItemOutGroup);

    return _enabled;
  }

  Future<void> move(int sessionId) async {
    if (!_enabled) {
      throw Exception('MoveOutGroupButton is not enabled');
    }

    final selectedTabsItem = ref.read(selectedTabsItemProvider);
    final idList = selectedTabsItem.keys.toList();

    List<matcha_tab.Tab> toMoveTabs = [];

    // target group
    final targetGroup = await ref.read(selectedTabGroupProvider.future);
    if (targetGroup == null) {
      throw Exception('No target group selected');
    }

    selectedTabsItem.values.map((item) {
      if (item is matcha_tab.Tab) {
        // reset groupId to null
        item.groupId = null;

        toMoveTabs.add(item);
      }
    }).toList();

    for (var element in toMoveTabs) {
      await ref
          .read(sessionContentProvider(sessionId).notifier)
          .moveTabOutGroup(element, targetGroup.id);
    }

    ///------------------------------------------

    // // remove from group
    // targetGroup.tabList.removeWhere((tab) {
    //   return idList.contains(tab.id);
    // });
    // await ref
    //     .read(sessionContentProvider(sessionId).notifier)
    //     .removeAllTabsItem(toMoveTabs);

    // // update  group
    // await ref
    //     .read(sessionContentProvider(sessionId).notifier)
    //     .updateTabsItem(targetGroup);

    // // add to session
    // await ref
    //     .read(sessionContentProvider(sessionId).notifier)
    //     .addAllTabsItem(toMoveTabs);

    ref.read(selectedTabsItemProvider.notifier).clearSelected();
  }
}

@riverpod
class MoveOutGroupButtonTap extends _$MoveOutGroupButtonTap {
  bool _enabled = false;

  bool _tabGroupOpened = false;

  @override
  bool build() {
    _tabGroupOpened = ref.watch(tabGroupOpenedProvider);

    // when TabGroup is Opened
    _enabled = _tabGroupOpened;

    return _enabled;
  }

  Future<void> move(int sessionId, matcha_tab.Tab tab) async {
    final link = ref.keepAlive();

    if (!_enabled) {
      throw Exception('MoveOutGroupButtonTap is not enabled');
    }

    // target group
    final targetGroup = await ref.read(selectedTabGroupProvider.future);
    if (targetGroup == null) {
      throw Exception('No target group selected');
    }

    await ref
        .read(sessionContentProvider(sessionId).notifier)
        .moveTabOutGroup(tab, targetGroup.id);
    // -------

    // // reset groupId to null
    // tab.groupId = null;

    // // remove from group
    // targetGroup.tabList.remove(tab);
    // await ref.read(sessionContentProvider(sessionId).notifier).removeTabsItem(tab);

    // // update  group
    // await ref
    //     .read(sessionContentProvider(sessionId).notifier)
    //     .updateTabsItem(targetGroup);

    // // add to session
    // await ref.read(sessionContentProvider(sessionId).notifier).updateTabsItem(tab);

    link.close();
  }
}
