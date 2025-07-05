import 'package:flutter/material.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/view_model/tab_manager/session_content_section/session_content_viewmodel.dart';

part 'move_tabs_item_dialog_viewmodel.g.dart';

@riverpod
class MoveTabsItemForm extends _$MoveTabsItemForm {
  late int _sessionId;

  bool _isValidated = false;
  int? _moveToSessionId;

  @override
  bool build(int sessionId) {
    _sessionId = sessionId;

    return _isValidated;
  }

  void setMoveToSessionId(int? moveToSessionId) {
    _moveToSessionId = moveToSessionId;

    _validate();
    state = _isValidated;
  }

  Future<void> save() async {
    if (!_isValidated) {
      throw Exception('MoveTabsItemForm is not valid');
    }

    final selectedList = ref.read(selectedTabsItemProvider);

    final tabsItemList = selectedList.values.toList();
    final idList = selectedList.keys.toList();

    for (var element in tabsItemList) {
       await ref
        .read(sessionContentProvider(sessionId).notifier)
        .moveToSession(element, _moveToSessionId!);
    }


   
    // ------
    // // remove from current session
    // await ref
    //     .read(sessionContentProvider(_sessionId).notifier)
    //     .removeAllTabsItem(tabsItemList);

    // // move to new session
    // await ref
    //     .read(sessionContentProvider(_moveToSessionId!).notifier)
    //     .addAllTabsItem(tabsItemList);

    //
    ref.read(selectedTabsItemProvider.notifier).clearSelected();
  }

  void _validate() {
    _isValidated = (_moveToSessionId != null);
  }
}

List<DropdownMenuEntry<int>> getSessionEntries(List<SessionMeta> sessionMetaList) {
  return sessionMetaList.map((sessionMeta) {
    return DropdownMenuEntry(value: sessionMeta.id, label: sessionMeta.name);
  }).toList();
}
