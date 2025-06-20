import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/edit_tab_dialog.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/edit_tab_group_dialog.dart';
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

part 'edit_button_viewmodel.g.dart';

@riverpod
class EditButton extends _$EditButton {
  bool _enabled = false;

  int _tabCount = 0;
  int _tabGroupCount = 0;

  bool _appTypeOnly = false;

  @override
  bool build() {
    ref.watch(selectedTabsItemProvider);

    _appTypeOnly = ref.read(selectedTabsItemProvider.notifier).isAppTypeOnly();

    _tabCount = ref.read(selectedTabsItemProvider.notifier).getTabCount();
    _tabGroupCount = ref.read(selectedTabsItemProvider.notifier).getTabGroupCount();

    // only when app type is selected
    if (!_appTypeOnly) {
      _enabled = false;
      return _enabled;
    }

    // only one tab or one tab group is selected
    _enabled =
        (_tabCount == 1 && _tabGroupCount == 0) ||
        (_tabCount == 0 && _tabGroupCount == 1);

    return _enabled;
  }

  void showEditDialog(BuildContext context, int sessionId) {
    if (!_enabled) {
      throw Exception('EditButton is not enabled');
    }

    final tabsItem = ref.read(selectedTabsItemProvider).values.first;
    editButtonTap(context, tabsItem, sessionId);

    ref.read(selectedTabsItemProvider.notifier).clearSelected();
  }
}

void editButtonTap(BuildContext context, TabsItem tabsItem, int sessionId) {
  if (tabsItem is matcha_tab.Tab) {
    showDialog(
      context: context,
      builder: (context) {
        return EditTabDialog(sessionId: sessionId, tab: tabsItem);
      },
    );
  } else if (tabsItem is matcha_tab_group.TabGroup) {
    showDialog(
      context: context,
      builder: (context) {
        return EditTabGroupDialog(sessionId: sessionId, tabGroup: tabsItem);
      },
    );
  }
}
