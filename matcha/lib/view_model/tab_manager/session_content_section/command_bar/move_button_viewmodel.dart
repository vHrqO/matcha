import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/ui/widgets/tab_manager/session_content_section/move_tabs_item_dialog/move_tabs_item_dialog.dart';
import 'package:matcha/view_model/tab_manager/session_list_viewmodel.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';

part 'move_button_viewmodel.g.dart';

@riverpod
class MoveButton extends _$MoveButton {
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

    // to_do: allow tab in group to move
    if (!_appTypeOnly || _hasItemInGroup) {
      _enabled = false;
      return _enabled;
    }

    _enabled = (_tabCount + _tabGroupCount) > 0;

    return _enabled;
  }

  Future<void> showMoveTabsItemDialog(BuildContext context, int id) async {
    if (!_enabled) {
      throw Exception('MoveButton is not enabled');
    }

    final sessionList = await ref.read(sessionListProvider.future);

    showDialog(
      context: context,
      builder: (context) =>
          MoveTabsItemDialog(sessionId: id, sessionMetaList: sessionList),
    );
  }
}
