import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';

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
    final appDb = ref.watch(tabDbProvider);

    // order by ui position
    final List<database.SessionData> queryResult =
        await (appDb
              //
              .select(appDb.session)
              ..orderBy([(t) => OrderingTerm(expression: t.position)]))
            .get();

    final List<SessionMeta> data = queryResult
        .map((item) => SessionMeta(id: item.id, name: item.name))
        .toList();

    return data;
  }

  Future<void> add(String name) async {
    final link = ref.keepAlive();

    final appDb = ref.read(tabDbProvider);

    final position = await getCount();

    await appDb
        .into(appDb.session)
        .insert(database.SessionCompanion.insert(name: name, position: position));

    ref.invalidateSelf();
    link.close();
  }

  Future<void> updateData(SessionMeta sessionMeta) async {
    final link = ref.keepAlive();

    final appDb = ref.read(tabDbProvider);

    await (appDb
          //
          .update(appDb.session)
          ..where((t) => t.id.equals(sessionMeta.id)))
        .write(database.SessionCompanion(name: Value(sessionMeta.name)));

    ref.invalidateSelf();
    link.close();
  }

  Future<void> delete(int id) async {
    final link = ref.keepAlive();

    final appDb = ref.read(tabDbProvider);

    await (appDb
          //
          .delete(appDb.session)
          ..where((t) => t.id.equals(id)))
        .go();

    // reorder after delete
    // '-1' for zero-based index
    final customQuery = """
      WITH Ordered AS (
        SELECT id, ROW_NUMBER() OVER (ORDER BY position) - 1 AS new_pos
        FROM Session
      )

      UPDATE Session
      SET position = (
        SELECT new_pos FROM Ordered WHERE Ordered.id = Session.id
      );
    """;
    await appDb.customUpdate(customQuery);

    ref.invalidateSelf();
    link.close();
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final link = ref.keepAlive();

    final appDb = ref.read(tabDbProvider);

    // swap positions
    await appDb.transaction(() async {
      // because UNIQUE constraint , Assign a tmp value
      // old position = -1
      await (appDb
            //
            .update(appDb.session)
            ..where((t) => t.position.equals(oldIndex)))
          .write(database.SessionCompanion(position: Value(-1)));

      // new position = old position
      await (appDb
            //
            .update(appDb.session)
            ..where((t) => t.position.equals(newIndex)))
          .write(database.SessionCompanion(position: Value(oldIndex)));

      // old position = new position
      await (appDb
            //
            .update(appDb.session)
            ..where((t) => t.position.equals(-1)))
          .write(database.SessionCompanion(position: Value(newIndex)));
    });

    ref.invalidateSelf();
    link.close();
  }

  Future<int> getCount() async {
    final link = ref.keepAlive();

    final appDb = ref.read(tabDbProvider);

    final countOfId = appDb.session.id.count();

    final queryResults =
        await (appDb
                //
                .select(appDb.session)
                .addColumns([countOfId]))
            .get();

    final count = queryResults.first.read(countOfId) ?? 0;

    link.close();
    return count;
  }
}
