import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/view_model/shared/app_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

part 'group_button_viewmodel.g.dart';

@riverpod
class GroupButton extends _$GroupButton {
  bool _enabled = false;

  int _tabCount = 0;
  int _tabGroupCount = 0;

  bool _appTypeOnly = false;
  bool _hasItemInGroup = false;

  @override
  bool build() {
    ref.watch(selectedTabsItemProvider);

    _appTypeOnly = ref.read(selectedTabsItemProvider.notifier).isAppTypeOnly();
    _hasItemInGroup = ref.read(selectedTabsItemProvider.notifier).hasItemInGroup();

    _tabCount = ref.read(selectedTabsItemProvider.notifier).getTabCount();
    _tabGroupCount = ref.read(selectedTabsItemProvider.notifier).getTabGroupCount();

    if (!_appTypeOnly || _hasItemInGroup) {
      _enabled = false;
      return _enabled;
    }

    // tab only or tab group only
    _enabled =
        (_tabCount > 0 && _tabGroupCount == 0) ||
        (_tabCount == 0 && _tabGroupCount == 1);

    return _enabled;
  }

  Future<void> toggle(int sessionId) async {
    if (!_enabled) {
      throw Exception('GroupButton is not enabled');
    }

    // group - tab only
    if (_tabCount > 0 && _tabGroupCount == 0) {
      final selectedTabs = ref.read(selectedTabsItemProvider);
      final idList = selectedTabs.keys.toList();

      // tmp , use repository to get from database
      // final groupItemId = DateTime.now().millisecondsSinceEpoch;

      final newTabGroup = matcha_tab_group.TabGroup(
        id: -1,
        type: TabsItemType.app,
        title: 'New TabGroup',
        tabList: selectedTabs.values.map((item) {
          item as matcha_tab.Tab;
          item.groupId = -1;
          return item;
        }).toList(),
      );

      await ref
          .read(sessionContentProvider(sessionId).notifier)
          .group(newTabGroup.tabList);
      //---
      // // remove tabs will be in new group
      // await ref
      //     .read(sessionContentProvider(sessionId).notifier)
      //     .removeAllTabsItem(selectedTabs.values.toList());

      // // add new tab group to session
      // await ref
      //     .read(sessionContentProvider(sessionId).notifier)
      //     .updateTabsItem(newTabGroup);

      ref.read(selectedTabsItemProvider.notifier).clearSelected();
      return;
    }

    // ungroup - tab group only
    if (_tabCount == 0 && _tabGroupCount == 1) {
      final selectedTabGroup =
          ref.read(selectedTabsItemProvider).values.first as matcha_tab_group.TabGroup;

      final tabGroup = selectedTabGroup;
      final tabList = selectedTabGroup.tabList;


      ref.read(tabGroupOpenedProvider.notifier).toggle(false);
      ref.read(selectedTabGroupProvider.notifier).clearSelected();
      await ref.read(sessionContentProvider(sessionId).notifier).ungroup(tabGroup);
      
      // -----
      // // remove group
      // ref.invalidate(tabGroupOpenedProvider);
      // await ref
      //     .read(sessionContentProvider(sessionId).notifier)
      //     .removeTabsItem(tabGroup);

      // // remove groupId
      // for (final tab in selectedTabGroup.tabList) {
      //   tab.groupId = null;
      // }

      // // add tabs to session
      // await ref
      //     .read(sessionContentProvider(sessionId).notifier)
      //     .addAllTabsItem(tabList);

      ref.read(selectedTabsItemProvider.notifier).clearSelected();
      return;
    }
  }
}
