import 'package:matcha/view_model/shared/app_viewmodel.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

part 'delete_button_viewmodel.g.dart';

@riverpod
class DeleteButton extends _$DeleteButton {
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

    // only when app type is selected
    // to_do: close broswer tab
    if (!_appTypeOnly) {
      _enabled = false;
      return _enabled;
    }

    // disable - selected tabgroup and hasItemInGroup = true
    if (_hasItemInGroup && _tabGroupCount != 0) {
      _enabled = false;
      return _enabled;
    }

    // has tabsitem
    _enabled = (_tabCount + _tabGroupCount) > 0;

    return _enabled;
  }

  Future<void> delete(int sessionId) async {
    if (!_enabled) {
      throw Exception('DeleteButton is not enabled');
    }

    final selectedTabsItem = ref.read(selectedTabsItemProvider);
    final idList = selectedTabsItem.keys.toList();

    // if tabgroup open, close it
    final tabGroupOpened = ref.read(tabGroupOpenedProvider);
    final selectedTabGroup = await ref.read(selectedTabGroupProvider.future);
    final isCurrentGroup = idList.contains(selectedTabGroup?.id);

    if (tabGroupOpened && isCurrentGroup) {
      ref.read(tabGroupOpenedProvider.notifier).toggle(false);
    }

    // remove tabs
    await ref
        .read(sessionContentProvider(sessionId).notifier)
        .removeAllTabsItem(selectedTabsItem.values.toList());

    ref.read(selectedTabsItemProvider.notifier).clearSelected();
  }
}

// to_do: refactor , prevent modfy other provider in build method
@riverpod
class DeleteButtonTap extends _$DeleteButtonTap {
  bool _enabled = false;

  int? _selectedSessionId;

  @override
  Future<bool> build() async {
    _selectedSessionId = await ref.watch(selectedSessionIdProvider.future);

    if (_selectedSessionId == null) {
      _enabled = false;
      return _enabled;
    }

    _enabled = true;

    return _enabled;
  }

  Future<void> delete(TabsItem tabsItem) async {
    if (!_enabled) {
      throw Exception('DeleteButtonTap is not enabled');
    }

    // if tabgroup open, close it
    final tabGroupOpened = ref.read(tabGroupOpenedProvider);
    final selectedTabGroup = await ref.read(selectedTabGroupProvider.future);
    final isCurrentGroup = tabsItem.id == selectedTabGroup?.id;

    if (tabGroupOpened && isCurrentGroup) {
      ref.read(tabGroupOpenedProvider.notifier).toggle(false);
    }

    // remove tabs
    await ref
        .read(sessionContentProvider(_selectedSessionId!).notifier)
        .removeTabsItem(tabsItem);

    ref.read(selectedTabsItemProvider.notifier).clearSelected();
  }
}
