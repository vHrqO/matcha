import 'package:flutter/material.dart';
import 'package:matcha/view_model/tab_manager/opened_tabs_card/opened_tabs_card_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/edit_tab_dialog.dart';
import 'package:matcha/ui/widgets/tab_manager/session_content_section/edit_tabs_item_dialog/edit_tab_group_dialog.dart';
import 'package:matcha/model/tabs_item/tabs_item.dart';
import 'package:matcha/model/tabs_item/tab.dart' as matcha_tab;
import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

part 'save_button_viewmodel.g.dart';

@riverpod
class SaveButton extends _$SaveButton {
  bool _enabled = false;

  int? _selectedSessionId;
  int? _selectedWindowId;

  @override
  Future<bool> build() async {
    final selectedWindowId = await ref.watch(selectedWindowIdProvider.future);

    final selectedSessionId = await ref.watch(selectedSessionIdProvider.future);

    if ((selectedWindowId == null) || (selectedSessionId == null)) {
      _enabled = false;
      return _enabled;
    }

    _selectedWindowId = selectedWindowId;
    _selectedSessionId = selectedSessionId;

    _enabled = true;

    return _enabled;
  }

  Future<void> save(TabsItem tabsItem) async {
    if (!_enabled) {
      throw Exception('SaveButton is not enabled');
    }

    final saveTabsItem = tabsItem;

    // to_do: can be optional
    // remove from window
    await ref
        .read(windowProvider(_selectedWindowId!).notifier)
        .removeTabsItem(tabsItem);

    // change type
    if (saveTabsItem is matcha_tab.Tab) {
      saveTabsItem.type = TabsItemType.app;
    } else if (saveTabsItem is matcha_tab_group.TabGroup) {
      saveTabsItem.type = TabsItemType.app;
      for (final tab in saveTabsItem.tabList) {
        tab.type = TabsItemType.app;
      }
    }

    // assign new id , from database
    saveTabsItem.id = DateTime.now().millisecondsSinceEpoch;

    // add to session
    await ref
        .read(sessionContentProvider(_selectedSessionId!).notifier)
        .updateTabsItem(saveTabsItem);

    ref.read(selectedTabsItemProvider.notifier).clearSelected();
  }
}
