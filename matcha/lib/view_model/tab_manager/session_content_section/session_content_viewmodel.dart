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
  late Session _session;

  @override
  Future<Session> build(int sessionId) async {
    // from database
    // not found , throw exception
    if (sessionId == 1) {
      _session = mockSession1;
    } else if (sessionId == 2) {
      _session = mockSession2;
    } else if (sessionId == 3) {
      _session = mockSession3;
    } else {
      _session = mockSession1;
    }

    return _session;
  }

  Future<void> updateSession(Session session) async {
    // to database
    _session = session;

    //
    ref.invalidateSelf();
    ref.read(selectedTabGroupProvider.notifier).dataHasChanged(_session.id , TabsItemType.app);
  }

  Future<void> updateSessionName(String name) async {
    // to database
    _session.name = name;

    //
    ref.invalidateSelf();
  }

  Future<void> updateTabsItem(TabsItem tabsItem) async {
    // to database
    // sql check - if id exists in database
    final isItemExists = _session.tabsItemList.any((item) => item.id == tabsItem.id);

    // final isItemExistsInGroup = _session.tabsItemList.any((item) {
    //   if (item is matcha_tab_group.TabGroup) {
    //     return item.tabList.any((item) => item.id == tabsItem.id);
    //   }
    //   return false;
    // },);

    if (isItemExists) {
      // update existing
      final index = _session.tabsItemList.indexWhere((item) => item.id == tabsItem.id);
      if (index != -1) {
        _session.tabsItemList[index] = tabsItem;
      }
    } else {
      // add new
      _session.tabsItemList.add(tabsItem);
    }

    //
    ref.invalidateSelf();
    ref.read(selectedTabGroupProvider.notifier).dataHasChanged(_session.id, TabsItemType.app);
  }

  Future<void> addAllTabsItem(List<TabsItem> tabsItemList) async {
    // to database
    for (final tab in tabsItemList) {
      // sql check - if id exists in database
      final isTabExists = _session.tabsItemList.any((item) => item.id == tab.id);
      if (isTabExists) {
        throw Exception("Tab with id ${tab.id} already exists");
      }
    }

    _session.tabsItemList.addAll(tabsItemList);

    //
    ref.invalidateSelf();
    ref.read(selectedTabGroupProvider.notifier).dataHasChanged(_session.id, TabsItemType.app);
  }

  Future<void> removeTabsItem(int id) async {
    // to database
    _session.tabsItemList.removeWhere((item) => item.id == id);

    //
    ref.invalidateSelf();
    ref.read(selectedTabGroupProvider.notifier).dataHasChanged(_session.id, TabsItemType.app);
  }

  Future<void> removeAllTabsItem(List<int> idList) async {
    // for (final id in idList) {
    //   ref.read(selectedTabsItemProvider.notifier).removeSelected(id);
    // }

    // to database
    _session.tabsItemList.removeWhere((item) => idList.contains(item.id));

    //
    ref.invalidateSelf();
    ref.read(selectedTabGroupProvider.notifier).dataHasChanged(_session.id, TabsItemType.app);
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
