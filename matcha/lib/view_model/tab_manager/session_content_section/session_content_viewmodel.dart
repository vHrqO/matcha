import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/repository/session_list_repo.dart';
import 'package:matcha/repository/session_repo.dart';
import 'package:matcha/repository/tab_group_repo.dart';
import 'package:matcha/view_model/shared/app_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/model/session/session.dart';
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/app/constants.dart';
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;

part 'session_content_viewmodel.g.dart';

@riverpod
class SessionContent extends _$SessionContent {
  late Session _session;

  int _sessionId = -1;

  @override
  Future<Session> build(int sessionId) async {
    _sessionId = sessionId;
    _session = await ref.watch(sessionRepoProvider(sessionId).future);

    return _session;
  }

  Future<void> updateSessionName(String name) async {
    // Wait for first state to be computed
    await future;

    await ref
        .read(sessionListRepoProvider.notifier)
        .updateData(SessionMeta(id: _sessionId, name: name));
  }

  Future<void> updateTabsItem(TabsItem tabsItem) async {
    await future;

    final exists = await ref
        .read(sessionRepoProvider(_sessionId).notifier)
        .hasTabsItem(tabsItem);

    if (exists) {
      if (tabsItem is matcha_tab_group.TabGroup) {
        await ref
            .read(sessionRepoProvider(_sessionId).notifier)
            .updateTabGroup(tabsItem);
      } else if (tabsItem is matcha_tab.Tab) {
        await ref.read(sessionRepoProvider(_sessionId).notifier).updateTab(tabsItem);
      }
    } else {
      if (tabsItem is matcha_tab_group.TabGroup) {
        await ref.read(sessionRepoProvider(_sessionId).notifier).addTabGroup(tabsItem);
      } else if (tabsItem is matcha_tab.Tab) {
        await ref.read(sessionRepoProvider(_sessionId).notifier).addTab(tabsItem);
      }
    }

    //
    ref.invalidateSelf();
  }

  Future<void> addAllTabsItem(List<TabsItem> tabsItemList) async {
    await future;

    // to_do : improve perf
    for (final item in tabsItemList) {
      await updateTabsItem(item);
    }

    //
    ref.invalidateSelf();
  }

  Future<void> removeTabsItem(TabsItem tabsItem) async {
    await future;

    await ref.read(sessionRepoProvider(_sessionId).notifier).removeTabsItem(tabsItem);

    //
    ref.invalidateSelf();
  }

  Future<void> removeAllTabsItem(List<TabsItem> tabsItemList) async {
    await future;

    // await ref.read(sessionRepoProvider(_sessionId).notifier).removeAllTabsItem(idList);

    // to_do : improve perf
    for (final item in tabsItemList) {
      await removeTabsItem(item);
    }

    //
    ref.invalidateSelf();
  }

  Future<void> moveTabInGroup(matcha_tab.Tab tab, int groupId) async {
    await future;

    await ref
        .read(sessionRepoProvider(_sessionId).notifier)
        .moveTabInGroup(tab, groupId);

    //
    ref.invalidateSelf();
  }

  Future<void> moveTabOutGroup(matcha_tab.Tab tab, int groupId) async {
    await future;

    await ref
        .read(sessionRepoProvider(_sessionId).notifier)
        .moveTabOutGroup(tab, groupId);

    //
    ref.invalidateSelf();
  }

  Future<void> moveToSession(TabsItem tabsItem, int newSessionId) async {
    await future;

    ref.read(tabGroupOpenedProvider.notifier).toggle(false);

    ref.read(tabGroupRepoProvider.notifier).clear();

    await ref
        .read(sessionRepoProvider(_sessionId).notifier)
        .moveToSession(tabsItem, newSessionId);

    //
    ref.invalidateSelf();
  }

  Future<void> group(List<matcha_tab.Tab> tabs) async {
    await future;

    await ref.read(sessionRepoProvider(_sessionId).notifier).group(tabs);

    //
    ref.invalidateSelf();
  }

  Future<void> ungroup(matcha_tab_group.TabGroup tabGroup) async {
    await future;

    await ref.read(sessionRepoProvider(_sessionId).notifier).ungroup(tabGroup);

    //
    ref.invalidateSelf();
  }
}

@riverpod
class SessionContentOrder extends _$SessionContentOrder {
  @override
  Future<void> build() async {
    //
  }

  Future<void> reorder({
    required int oldIndex,
    required int newIndex,
    required int sessionId,
  }) async {
    final link = ref.keepAlive();

    await ref
        .read(sessionOrderRepoProvider.notifier)
        .reorder(oldIndex: oldIndex, newIndex: newIndex, sessionId: sessionId);

    ref.invalidate(sessionContentProvider);
    link.close();
  }

  Future<void> reorderInGroup({
    required int oldIndex,
    required int newIndex,
    required int groupId,
  }) async {
    final link = ref.keepAlive();

    await ref
        .read(sessionOrderRepoProvider.notifier)
        .reorderInGroup(oldIndex: oldIndex, newIndex: newIndex, groupId: groupId);

    ref.invalidate(sessionContentProvider);
    link.close();
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
