import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/repository/session_list_repo.dart';
import 'package:matcha/repository/session_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/mock_data/session.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/model/session/session.dart';
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/app/constants.dart';
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;

part 'session_content_viewmodel.g.dart';

@riverpod
class SessionContent extends _$SessionContent {
  // to_do : no late
  late Session _session;

  @override
  Future<Session> build(int sessionId) async {
    _session = await ref.watch(sessionRepoProvider(sessionId).future);

    return _session;
  }

  Future<void> updateSessionName(String name) async {
    await ref
        .read(sessionListRepoProvider.notifier)
        .updateData(SessionMeta(id: _session.id, name: name));
  }

  Future<void> updateTabsItem(TabsItem tabsItem) async {
    final exists = await ref
        .read(sessionRepoProvider(_session.id).notifier)
        .hasTabsItem(tabsItem);

    if (exists) {
      if (tabsItem is matcha_tab_group.TabGroup) {
        await ref
            .read(sessionRepoProvider(_session.id).notifier)
            .updateTabGroup(tabsItem);
      } else if (tabsItem is matcha_tab.Tab) {
        await ref.read(sessionRepoProvider(_session.id).notifier).updateTab(tabsItem);
      }
    } else {
      if (tabsItem is matcha_tab_group.TabGroup) {
        await ref.read(sessionRepoProvider(_session.id).notifier).addTabGroup(tabsItem);
      } else if (tabsItem is matcha_tab.Tab) {
        await ref.read(sessionRepoProvider(_session.id).notifier).addTab(tabsItem);
      }
    }

    //
    ref.invalidateSelf();
    ref
        .read(selectedTabGroupProvider.notifier)
        .dataHasChanged(_session.id, TabsItemType.app);
  }

  Future<void> addAllTabsItem(List<TabsItem> tabsItemList) async {
    // to_do : improve perf
    for (final item in tabsItemList) {
      await updateTabsItem(item);
    }

    //
    ref.invalidateSelf();
    ref
        .read(selectedTabGroupProvider.notifier)
        .dataHasChanged(_session.id, TabsItemType.app);
  }

  Future<void> removeTabsItem(TabsItem tabsItem) async {
    await ref.read(sessionRepoProvider(_session.id).notifier).removeTabsItem(tabsItem);

    //
    ref.invalidateSelf();
    ref
        .read(selectedTabGroupProvider.notifier)
        .dataHasChanged(_session.id, TabsItemType.app);
  }

  Future<void> removeAllTabsItem(List<TabsItem> tabsItemList) async {
    // await ref.read(sessionRepoProvider(_session.id).notifier).removeAllTabsItem(idList);

    // to_do : improve perf
    for (final item in tabsItemList) {
      await removeTabsItem(item);
    }

    //
    ref.invalidateSelf();
    ref
        .read(selectedTabGroupProvider.notifier)
        .dataHasChanged(_session.id, TabsItemType.app);
  }

  Future<void> moveTabInGroup(matcha_tab.Tab tab, int groupId) async {
    // to_do : refactor selectedTabGroupProvider

    await ref
        .read(sessionRepoProvider(_session.id).notifier)
        .moveTabInGroup(tab, groupId);

    //
    ref.invalidateSelf();
    ref
        .read(selectedTabGroupProvider.notifier)
        .dataHasChanged(_session.id, TabsItemType.app);
  }
}

@riverpod
class SessionContentOrder extends _$SessionContentOrder {
  @override
  Future<void> build() async {
    //
  }

  Future<void> reorder(int oldIndex, int newIndex, int oldId, int newId) async {
    await ref
        .read(sessionOrderRepoProvider.notifier)
        .reorder(oldIndex, newIndex, oldId, newId);
  }

  Future<void> reorderInGroup(int oldIndex, int newIndex, int oldId, int newId) async {
    await ref
        .read(sessionOrderRepoProvider.notifier)
        .reorderInGroup(oldIndex, newIndex, oldId, newId);
  }
}

@riverpod
Future<Session?> selectedSession(Ref ref) async {
  final int? selectedSessionId = await ref.watch(selectedSessionIdProvider.future);
  if (selectedSessionId == null) {
    // if not selected, return null as loading state
    return null;
  }

  final selectedSession = await ref.watch(
    sessionContentProvider(selectedSessionId).future,
  );

  return selectedSession;
}

// ui order
@riverpod
class TabsItemListSortOrder extends _$TabsItemListSortOrder {
  SortOrder _sortOrder = SortOrder.custom;

  @override
  SortOrder build() {
    return _sortOrder;
  }

  void setOrder(SortOrder order) {
    _sortOrder = order;

    state = _sortOrder;
  }
}

@riverpod
Future<Session?> sortedSelectedSession(Ref ref) async {
  final selectedSession = await ref.watch(selectedSessionProvider.future);
  if (selectedSession == null) {
    // if not selected, return null as loading state
    return null;
  }

  final tabsItemListSortOrder = ref.watch(tabsItemListSortOrderProvider);

  // If the sort order is custom, return the original
  if (tabsItemListSortOrder == SortOrder.custom) {
    return selectedSession;
  }

  // use a shallow copy to sort only on ui , not store
  final selectedSessionShallow = Session(
    id: selectedSession.id,
    name: selectedSession.name,
    tabsItemList: List.of(selectedSession.tabsItemList),
  );

  selectedSessionShallow.tabsItemList.sort((TabsItem a, TabsItem b) {
    final aName = a.title;
    final bName = b.title;

    switch (tabsItemListSortOrder) {
      case SortOrder.ascending:
        return aName.compareTo(bName);
      case SortOrder.descending:
        return bName.compareTo(aName);
      case SortOrder.custom:
        return 0;
    }
  });

  return selectedSessionShallow;
}

@riverpod
String statusBarText(Ref ref) {
  ref.watch(selectedTabsItemProvider);

  final tabCount = ref.read(selectedTabsItemProvider.notifier).getTabCount();
  final tabGroupCount = ref.read(selectedTabsItemProvider.notifier).getTabGroupCount();

  final selectedCount = tabCount + tabGroupCount;

  if (selectedCount == 0) {
    return "";
  }

  return "Selected $selectedCount items";
}
