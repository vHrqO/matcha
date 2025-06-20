import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/mock_data/session_list.dart';
import 'package:matcha/view_model/shared/selected_viewmodel.dart';
import 'package:matcha/app/constants.dart';

part 'session_list_viewmodel.g.dart';

// to_do: rename to sessionMetaList?
@riverpod
class SessionList extends _$SessionList {
  List<SessionMeta>? _sessionList;

  @override
  Future<List<SessionMeta>> build() async {
    // from database
    _sessionList ??= mockSessionList1;

    return _sessionList!;
  }

  Future<void> updateSessionList(List<SessionMeta> sessions) async {
    // to database

    //
    state = AsyncData(sessions);
  }

  Future<void> addSession(String name) async {
    if (_sessionList == null) {
      throw Exception('Sessions not initialized');
    }

    // to database
    final lastId = _sessionList!.isNotEmpty ? _sessionList!.last.id : 0;
    _sessionList!.add(SessionMeta(id: lastId + 1, name: name));

    //
    state = AsyncData(_sessionList!);
  }

  Future<void> deleteSession(int sessionId) async {
    if (_sessionList == null) {
      throw Exception('Sessions not initialized');
    }

    // to database
    _sessionList!.removeWhere((session) => session.id == sessionId);

    // reset selected session id
    ref.invalidate(selectedSessionIdProvider);

    state = AsyncData(_sessionList!);
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
