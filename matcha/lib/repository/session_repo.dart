import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/repository/session_list_repo.dart';
import 'package:matcha/view_model/shared/database_viewmodel.dart';
import 'package:matcha/model/session/session.dart';
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;

part 'session_repo.g.dart';

@riverpod
class SessionRepo extends _$SessionRepo {
  int _sessionId = -1;

  @override
  Future<Session> build(int sessionId) async {
    _sessionId = sessionId;

    ref.watch(sessionListRepoProvider);
    final tabDb = ref.watch(tabDbProvider);

    final List<TabsItem> data = [];
    final sessionName = await tabDb.getSessionName(_sessionId).getSingle();

    final outGroupTabsItems = await tabDb.getAllOutGroupTabsItems(_sessionId).get();
    for (final element in outGroupTabsItems) {
      if (element.isGroup) {
        // add group

        // tabs in group
        final List<matcha_tab.Tab> tabList = [];

        final tabsItemsInGroup = await tabDb
            .getAllInGroupTabsItems(_sessionId, element.id)
            .get();
        for (final tabElement in tabsItemsInGroup) {
          final tab = matcha_tab.Tab(
            id: tabElement.id,
            groupId: element.id,
            type: TabsItemType.app,
            title: tabElement.title,
            url: tabElement.url,
            tagList: tabElement.tagList?.split(',') ?? [],
          );

          tabList.add(tab);
        }

        // create group
        final group = matcha_tab_group.TabGroup(
          id: element.id,
          type: TabsItemType.app,
          title: element.title,
          tabList: tabList,
          tagList: element.tagList?.split(',') ?? [],
        );

        data.add(group);
      } else {
        // add tab
        final tab = matcha_tab.Tab(
          id: element.id,
          groupId: null,
          type: TabsItemType.app,
          title: element.title,
          url: element.url!,
          tagList: element.tagList?.split(',') ?? [],
        );

        data.add(tab);
      }
    }

    return Session(id: _sessionId, name: sessionName, tabsItemList: data);
  }

  Future<bool> hasTabsItem(TabsItem tabsItem) async {
    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);
    final exists = await tabDb.hasTabsItem(tabsItem.id).getSingle();

    link.close();
    return exists;
  }

  Future<void> updateTab(matcha_tab.Tab tab) async {
    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);
    final savedAllTags = await tabDb.getAllTags(tab.id).get();

    await tabDb.transaction(() async {
      // update TabsItem
      await tabDb.updateTabsItem(tab.title, tab.id);

      // update Tab
      await tabDb.updateTab(tab.url, tab.id);

      // update Tags
      for (final tag in savedAllTags) {
        if (!tab.tagList.contains(tag)) {
          await tabDb.removeTag(tab.id, tag);
        }
      }

      for (final tag in tab.tagList) {
        if (!savedAllTags.contains(tag)) {
          await tabDb.addTag(tab.id, tag);
        }
      }
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> updateTabGroup(matcha_tab_group.TabGroup tabGroup) async {
    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);
    final savedAllTags = await tabDb.getAllTags(tabGroup.id).get();

    await tabDb.transaction(() async {
      // update TabsItem
      await tabDb.updateTabsItem(tabGroup.title, tabGroup.id);

      // update TabGroup
      await tabDb.updateTabGroup(tabGroup.title, tabGroup.id);

      // update Tabs in Group
      for (final tab in tabGroup.tabList) {
        if (!await hasTabsItem(tab)) {
          await addTab(tab);
        }
      }

      // update Tags
      for (final tag in savedAllTags) {
        if (!tabGroup.tagList.contains(tag)) {
          await tabDb.removeTag(tabGroup.id, tag);
        }
      }

      for (final tag in tabGroup.tagList) {
        if (!savedAllTags.contains(tag)) {
          await tabDb.addTag(tabGroup.id, tag);
        }
      }
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> addTab(matcha_tab.Tab tab) async {
    // Wait for first state to be computed
    await future;

    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);
    final inGroup = tab.groupId != null;

    await tabDb.transaction(() async {
      // Add TabsItem
      await tabDb.addTabsItem(_sessionId, inGroup, false, tab.title);
      final newItemId = await tabDb.getLatestAddId().getSingle();

      // Add Tab
      if (inGroup) {
        await tabDb.addTabInGroup(newItemId, tab.groupId, tab.url);
      } else {
        await tabDb.addTab(newItemId, tab.url);
      }

      // Add Tags
      for (final tag in tab.tagList) {
        await tabDb.addTag(newItemId, tag);
      }
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> addTabGroup(matcha_tab_group.TabGroup tabGroup) async {
    await future;

    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);

    await tabDb.transaction(() async {
      // Add TabsItem
      await tabDb.addTabsItem(_sessionId, false, true, tabGroup.title);
      final newItemId = await tabDb.getLatestAddId().getSingle();

      // Add TabGroup
      await tabDb.addTabGroup(newItemId, "grey");
      final groupId = await tabDb.getLatestAddId().getSingle();

      // Add Tabs in Group
      for (final tab in tabGroup.tabList) {
        tab.groupId = groupId; // Set groupId for each tab
        await addTab(tab);
      }

      // Add Tags
      for (final tag in tabGroup.tagList) {
        await tabDb.addTag(newItemId, tag);
      }
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> removeTabsItem(TabsItem tabsItem) async {
    await future;

    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);
    final inGroup = tabsItem is matcha_tab.Tab && tabsItem.groupId != null;

    await tabDb.transaction(() async {
      await tabDb.removeTabsItem(tabsItem.id);

      if (inGroup) {
        await tabDb.refreshPositionTabInGroup(tabsItem.groupId);
      } else {
        await tabDb.refreshPositionTabsItem(_sessionId);
      }
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> moveTabInGroup(matcha_tab.Tab tab, int groupId) async {
    await future;

    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);

    await tabDb.transaction(() async {
      await tabDb.moveTabInGroup_removeFromOut(tab.id);

      await tabDb.moveTabInGroup_AddToGroup(groupId, tab.id);

      await tabDb.refreshPositionTabsItem(_sessionId);
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> moveTabOutGroup(matcha_tab.Tab tab, int groupId) async {
    await future;

    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);

    await tabDb.transaction(() async {
      await tabDb.moveTabOutGroup_removeFromGroup(tab.id);

      await tabDb.moveTabOutGroup_AddToOut(_sessionId, tab.id);

      await tabDb.refreshPositionTabInGroup(groupId);
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> moveToSession(TabsItem tabsItem, int newSessionId) async {
    await future;

    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);
    final inGroup = (tabsItem is matcha_tab.Tab) && (tabsItem.groupId != null);
    final isGroup = tabsItem is matcha_tab_group.TabGroup;

    await tabDb.transaction(() async {
      await tabDb.moveToSession(newSessionId, tabsItem.id);

      if (isGroup) {
        await tabDb.moveToSession_TabInGroup(newSessionId, tabsItem.id);
      }

      if (inGroup) {
        await tabDb.refreshPositionTabInGroup(tabsItem.groupId);
      } else {
        await tabDb.refreshPositionTabsItem(_sessionId);
      }
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> group(List<matcha_tab.Tab> tabs) async {
    await future;

    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);

    await tabDb.transaction(() async {
      // Add TabsItem
      await tabDb.addTabsItem(_sessionId, false, true, "New TabGroup");
      final newItemId = await tabDb.getLatestAddId().getSingle();

      // Add TabGroup
      await tabDb.addTabGroup(newItemId, "grey");
      final groupId = await tabDb.getLatestAddId().getSingle();

      // Move TabsItem to Group
      for (final tab in tabs) {
        await tabDb.moveTabInGroup_removeFromOut(tab.id);
        await tabDb.moveTabInGroup_AddToGroup(groupId, tab.id);
      }

      //
      await tabDb.refreshPositionTabsItem(_sessionId);
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> ungroup(matcha_tab_group.TabGroup tabGroup) async {
    await future;

    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);

    await tabDb.transaction(() async {
      // Move TabsItem out
      for (final tab in tabGroup.tabList) {
        await tabDb.moveTabOutGroup_removeFromGroup(tab.id);
        await tabDb.moveTabOutGroup_AddToOut(_sessionId, tab.id);
      }

      // Remove TabGroup
      await tabDb.removeTabsItem(tabGroup.id);

      await tabDb.refreshPositionTabsItem(_sessionId);
    });

    ref.invalidateSelf();
    link.close();
  }
}

@riverpod
class SessionOrderRepo extends _$SessionOrderRepo {
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

    if (oldIndex == newIndex) {
      throw ArgumentError('oldIndex and newIndex cannot be the same');
    }

    final tabDb = ref.read(tabDbProvider);

    await tabDb.transaction(() async {
      if (oldIndex < newIndex) {
        await tabDb.reorderTabsItem_shiftDown(oldIndex, newIndex, sessionId);
      } else if (oldIndex > newIndex) {
        await tabDb.reorderTabsItem_shiftUp(oldIndex, newIndex, sessionId);
      }

      final isUnique = await tabDb.isTabsItemPositionUnique(sessionId).getSingle();
      if (!isUnique) {
        print("tabs_item.position is not unique, refreshing positions");
        await tabDb.refreshPositionTabsItem(sessionId);
      }
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> reorderInGroup({
    required int oldIndex,
    required int newIndex,
    required int groupId,
  }) async {
    final link = ref.keepAlive();

    if (oldIndex == newIndex) {
      throw ArgumentError('oldIndex and newIndex cannot be the same');
    }

    final tabDb = ref.read(tabDbProvider);

    await tabDb.transaction(() async {
      if (oldIndex < newIndex) {
        await tabDb.reorderTabIn_shiftDown(oldIndex, newIndex, groupId);
      } else if (oldIndex > newIndex) {
        await tabDb.reorderTabIn_shiftUp(oldIndex, newIndex, groupId);
      }

      final isUnique = await tabDb.isTabInGroupPositionUnique(groupId).getSingle();
      if (!isUnique) {
        print("tab.position is not unique, refreshing positions");
        await tabDb.refreshPositionTabInGroup(groupId);
      }
    });

    ref.invalidateSelf();
    link.close();
  }
}
