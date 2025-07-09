import 'package:matcha/model/session/session.dart';
import 'package:matcha/repository/tab_group_repo.dart';
import 'package:matcha/view_model/shared/app_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/opened_tabs_card/opened_tabs_card_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_list_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;

part 'selected_viewmodel.g.dart';

@riverpod
class SelectedSessionId extends _$SelectedSessionId {
  int? _sessionId;

  @override
  Future<int?> build() async {
    // init use first session id when sessionList not empty
    if (_sessionId == null) {
      final sessionList = await ref.read(sessionListProvider.future);
      _sessionId = sessionList.isNotEmpty ? sessionList[0].id : null;
    }

    return _sessionId;
  }

  void updateSelected(int sessionId) {
    _sessionId = sessionId;

    state = AsyncData(_sessionId);
  }
}

@riverpod
class SelectedTabsItem extends _$SelectedTabsItem {
  // id , TabsItem
  // to_do: optimize ?
  final Map<int, TabsItem> _selectedTabsItem = {};
  final Map<int, TabsItem> _selectedTabsItemBrowser = {};

  // to_do: use single class to return?
  int _tabCount = 0;
  int _tabGroupCount = 0;

  // if only TabsItemType.app is selected
  bool _appTypeOnly = true;

  // if any item is in group
  bool _itemInGroup = false;

  @override
  bool updateShouldNotify(Map<int, TabsItem> previous, Map<int, TabsItem> next) {
    // always notify
    return true;
  }

  @override
  Map<int, TabsItem> build() {
    // return copy instead?
    return _selectedTabsItem;
  }

  void addSelected(TabsItem item) {
    if (item is matcha_tab.Tab && item.groupId != null) {
      _itemInGroup = true;
    }

    if (item.type == TabsItemType.app) {
      _selectedTabsItem[item.id] = item;
    } else {
      _selectedTabsItemBrowser[item.id] = item;
      _appTypeOnly = false;
    }

    if (item is matcha_tab.Tab) {
      _tabCount++;
    } else {
      _tabGroupCount++;
    }

    state = _selectedTabsItem;
  }

  void removeSelected(TabsItem item) {
    TabsItem? removedItem;

    if (item.type == TabsItemType.app) {
      removedItem = _selectedTabsItem.remove(item.id);
    } else {
      removedItem = _selectedTabsItemBrowser.remove(item.id);
    }

    _appTypeOnly = _selectedTabsItemBrowser.isEmpty;

    final appItemInGroup = _selectedTabsItem.values.any(
      (item) => item is matcha_tab.Tab && item.groupId != null,
    );

    final browserItemInGroup = _selectedTabsItemBrowser.values.any(
      (item) => item is matcha_tab.Tab && item.groupId != null,
    );

    _itemInGroup = appItemInGroup || browserItemInGroup;

    if (removedItem != null) {
      if (item is matcha_tab.Tab) {
        _tabCount--;
      } else {
        _tabGroupCount--;
      }
    } else {
      throw ArgumentError('$item not found in selected TabsItem.');
    }

    state = _selectedTabsItem;
  }

  void clearSelected() {
    _selectedTabsItem.clear();
    _selectedTabsItemBrowser.clear();

    _appTypeOnly = true;
    _itemInGroup = false;

    _tabCount = 0;
    _tabGroupCount = 0;

    state = _selectedTabsItem;
  }

  bool isSelected(TabsItem tabsItem) {
    // return _selectedTabsItem.values.any((item) {
    //   return (item.id == tabsItem.id) && (item.type == tabsItem.type);
    // });

    // return _selectedTabsItem.containsKey(id);

    if (tabsItem.type == TabsItemType.app) {
      return _selectedTabsItem.containsKey(tabsItem.id);
    } else {
      return _selectedTabsItemBrowser.containsKey(tabsItem.id);
    }
  }

  bool isAppTypeOnly() {
    return _appTypeOnly;
  }

  bool hasItemInGroup() {
    return _itemInGroup;
  }

  bool hasItemOutGroup() {
    final appItemInGroup = _selectedTabsItem.values.any(
      (item) => item is matcha_tab.Tab && item.groupId == null,
    );

    final browserItemInGroup = _selectedTabsItemBrowser.values.any(
      (item) => item is matcha_tab.Tab && item.groupId == null,
    );

    return appItemInGroup || browserItemInGroup;
  }

  int getTabCount() {
    return _tabCount;
  }

  int getTabGroupCount() {
    return _tabGroupCount;
  }
}

@riverpod
class SelectedTabGroup extends _$SelectedTabGroup {
  @override
  Future<matcha_tab_group.TabGroup?> build() async {
    final tabGroupRepoState = ref.watch(tabGroupRepoProvider);
    final savedTabGroup = tabGroupRepoState.tabGroup;
    final sourceId = tabGroupRepoState.sourceId;

    if (savedTabGroup == null) {
      return null;
    }

    //
    Future<matcha_tab_group.TabGroup?> getOpenedTabGroup({
      required Future<int?> idFuture,
      required Future<matcha_tab_group.TabGroup?> Function(int currentId)
      contentCallback,
    }) async {
      //
      final currentId = await idFuture;
      if (currentId == null) {
        return null;
      }

      // id changed , close current tab group
      if (currentId != sourceId) {
        ref.read(tabGroupOpenedProvider.notifier).toggle(false);
        return null;
      }

      // get latest TabGroup
      final openedTabGroup = await contentCallback(currentId);

      return openedTabGroup;
    }

    switch (savedTabGroup.type) {
      case TabsItemType.app:
        final sessionIdFuture = ref.watch(selectedSessionIdProvider.future);

        final openedTabGroup = await getOpenedTabGroup(
          idFuture: sessionIdFuture,
          contentCallback: (currentId) async {
            final session = await ref.watch(sessionContentProvider(currentId).future);

            try {
              return session.tabsItemList.firstWhere(
                    (item) => item.id == savedTabGroup.id,
                  )
                  as matcha_tab_group.TabGroup;
            } on StateError catch (e) {
              print('TabGroup not found in session: $e');
              return null;
            }
          },
        );

        return openedTabGroup;

      case TabsItemType.browser:
        final windowIdFuture = ref.watch(selectedWindowIdProvider.future);

        final openedTabGroup = await getOpenedTabGroup(
          idFuture: windowIdFuture,
          contentCallback: (currentId) async {
            final window = await ref.read(windowProvider(currentId).future);

            try {
              return window.tabsItemList.firstWhere(
                    (item) => item.id == savedTabGroup.id,
                  )
                  as matcha_tab_group.TabGroup;
            } on StateError catch (e) {
              print('TabGroup not found in window: $e');
              return null;
            }
          },
        );

        return openedTabGroup;
    }
  }

  Future<void> setSelected(matcha_tab_group.TabGroup tabGroup) async {
    final sessionId = await ref.watch(selectedSessionIdProvider.future);
    if (sessionId == null) {
      throw Exception('No session selected');
    }

    ref.read(tabGroupRepoProvider.notifier).save(tabGroup, sessionId);

    ref.invalidateSelf();
  }

  void clearSelected() {
    ref.read(tabGroupRepoProvider.notifier).clear();

    ref.invalidateSelf();
  }

  bool isSelected(matcha_tab_group.TabGroup tabGroup) {
    final tabGroupRepoState = ref.read(tabGroupRepoProvider);
    final savedTabGroup = tabGroupRepoState.tabGroup;

    return (savedTabGroup?.id == tabGroup.id) && (savedTabGroup?.type == tabGroup.type);
  }
}

//
@riverpod
class SelectedWindowId extends _$SelectedWindowId {
  int? _windowId;

  @override
  Future<int?> build() async {
    // init use first window id when windowList not empty
    if (_windowId == null) {
      final windowList = await ref.read(windowListProvider.future);
      _windowId = windowList.isNotEmpty ? windowList[0].id : null;
    }

    return _windowId;
  }

  Future<void> updateSelected(int tabIndex) async {
    final windowList = await ref.read(windowListProvider.future);
    _windowId = windowList.isNotEmpty ? windowList[tabIndex].id : null;

    state = AsyncData(_windowId);
  }
}
