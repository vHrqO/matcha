import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/tabs_item/tab_group.dart' as matcha_tab_group;

part 'tab_group_repo.g.dart';

@riverpod
class TabGroupRepo extends _$TabGroupRepo {
  matcha_tab_group.TabGroup? _savedTabGroup;

  // sessionId or windowId
  int? _sourceId;

  @override
  ({matcha_tab_group.TabGroup? tabGroup, int? sourceId}) build() {
    return (tabGroup: _savedTabGroup, sourceId: _sourceId);
  }

  void save(matcha_tab_group.TabGroup tabGroup, int sourceId) {
    _savedTabGroup = tabGroup;
    _sourceId = sourceId;

    state = (tabGroup: _savedTabGroup, sourceId: _sourceId);
  }

  void clear() {
    _savedTabGroup = null;
    _sourceId = null;

    state = (tabGroup: _savedTabGroup, sourceId: _sourceId);
  }
}
