import 'package:matcha/repository/session_list_repo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/mock_data/session_list.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/app/constants.dart';
import 'package:collection/collection.dart';

part 'session_list_viewmodel.g.dart';

@riverpod
class SessionList extends _$SessionList {
  @override
  Future<List<SessionMeta>> build() async {
    final sessionList = await ref.watch(sessionListRepoProvider.future);

    return sessionList;
  }

  Future<void> add(String name) async {
    await ref.read(sessionListRepoProvider.notifier).add(name);
  }

  Future<void> delete(int sessionId) async {
    await ref.read(sessionListRepoProvider.notifier).delete(sessionId);
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    await ref.read(sessionListRepoProvider.notifier).reorder(oldIndex, newIndex);
  }
}

// ui order
@riverpod
class SessionListSortOrder extends _$SessionListSortOrder {
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
Future<List<SessionMeta>> sortedSessionList(Ref ref) async {
  final sessionList = await ref.watch(sessionListProvider.future);
  final sessionListSortOrder = ref.watch(sessionListSortOrderProvider);

  // If the sort order is custom, return the original sessions
  if (sessionListSortOrder == SortOrder.custom) {
    return sessionList;
  }

  // use a shallow copy to sort only on ui , not store
  final sessionListShallow = List.of(sessionList);

  sessionListShallow.sort((SessionMeta a, SessionMeta b) {
    final aName = a.name;
    final bName = b.name;

    switch (sessionListSortOrder) {
      case SortOrder.ascending:
        return aName.compareTo(bName);
      case SortOrder.descending:
        return bName.compareTo(aName);
      case SortOrder.custom:
        return 0;
    }
  });

  return sessionListShallow;
}
