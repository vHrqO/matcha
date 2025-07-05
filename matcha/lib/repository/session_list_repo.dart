import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/database/database.dart' as database;
import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/view_model/shared/database_viewmodel.dart';

part 'session_list_repo.g.dart';

/// Manually keep the provider alive by using `ref.keepAlive()` to
/// prevent it from being destroyed during an async gap,
/// which could otherwise result in accessing `ref` after it has been disposed.
/// Using `ref.watch()` instead of `ref.read()` can help avoid this issue.
/// https://github.com/rrousselGit/riverpod/issues/4096
@riverpod
class SessionListRepo extends _$SessionListRepo {
  // getAll()
  @override
  Future<List<SessionMeta>> build() async {
    final tabDb = ref.watch(tabDbProvider);

    final List<database.SessionData> queryResult = await tabDb.getAllSession().get();

    final List<SessionMeta> data = queryResult
        .map((item) => SessionMeta(id: item.id, name: item.name))
        .toList();

    return data;
  }

  Future<void> add(String name) async {
    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);

    await tabDb.addSession(name);

    ref.invalidateSelf();
    link.close();
  }

  Future<void> updateData(SessionMeta sessionMeta) async {
    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);

    await tabDb.updateSession(sessionMeta.name, sessionMeta.id);

    ref.invalidateSelf();
    link.close();
  }

  Future<void> remove(int id) async {
    final link = ref.keepAlive();

    final tabDb = ref.read(tabDbProvider);

    await tabDb.transaction(() async {
      await tabDb.removeSession(id);

      await tabDb.refreshPositionSession();
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<void> reorder({required int oldIndex, required int newIndex}) async {
    final link = ref.keepAlive();

    if (oldIndex == newIndex) {
      throw ArgumentError('oldIndex and newIndex cannot be the same');
    }

    final tabDb = ref.read(tabDbProvider);

    await tabDb.transaction(() async {
      final safeOffset = await tabDb.reorderSession_getSafeOffset().getSingle();

      await tabDb.reorderSession_addOffset(safeOffset, oldIndex, newIndex);

      if (oldIndex < newIndex) {
        await tabDb.reorderSession_shiftDownAndBack(safeOffset, oldIndex, newIndex);
      } else if (oldIndex > newIndex) {
        await tabDb.reorderSession_shiftUpAndBack(safeOffset, oldIndex, newIndex);
      }
    });

    link.close();
  }
}
