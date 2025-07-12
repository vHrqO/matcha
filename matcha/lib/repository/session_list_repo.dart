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
    final tabDb = await ref.watch(tabDbProvider.future);

    final List<database.SessionData> queryResult = await tabDb.getAllSession().get();

    final List<SessionMeta> data = queryResult
        .map((item) => SessionMeta(id: item.id, name: item.name))
        .toList();

    return data;
  }

  Future<void> add(String name) async {
    final link = ref.keepAlive();

    final tabDb = await ref.read(tabDbProvider.future);

    await tabDb.addSession(name: name);

    ref.invalidateSelf();
    link.close();
  }

  Future<void> updateData(SessionMeta sessionMeta) async {
    final link = ref.keepAlive();

    final tabDb = await ref.read(tabDbProvider.future);

    await tabDb.updateSession(name: sessionMeta.name, id: sessionMeta.id);

    ref.invalidateSelf();
    link.close();
  }

  Future<void> remove(int id) async {
    final link = ref.keepAlive();

    final tabDb = await ref.read(tabDbProvider.future);

    await tabDb.transaction(() async {
      await tabDb.removeSession(id: id);

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

    final tabDb = await ref.read(tabDbProvider.future);

    await tabDb.transaction(() async {
      if (oldIndex < newIndex) {
        await tabDb.reorderSession_shiftDown(oldIndex: oldIndex, newIndex: newIndex);
      } else if (oldIndex > newIndex) {
        await tabDb.reorderSession_shiftUp(oldIndex: oldIndex, newIndex: newIndex);
      }

      final isUnique = await tabDb.isSessionPositionUnique().getSingle();
      if (!isUnique) {
        print("session.position is not unique, refreshing positions");
        await tabDb.refreshPositionSession();
      }
    });

    ref.invalidateSelf();
    link.close();
  }
}
