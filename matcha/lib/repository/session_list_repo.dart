import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:drift/drift.dart';

import 'package:matcha/database/database.dart' as database;
import 'package:matcha/model/session/session_meta.dart';
import 'package:matcha/view_model/shared/app_viewmodel.dart';

part 'session_list_repo.g.dart';

@riverpod
class SessionListRepo extends _$SessionListRepo {
  // getAll()
  @override
  Future<List<SessionMeta>> build() async {
    final appDb = ref.watch(appDbProvider);

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

  Future<void> add(String name, int position) async {
    final appDb = ref.read(appDbProvider);

    await appDb
        .into(appDb.session)
        .insert(database.SessionCompanion.insert(name: name, position: position));

    // only if still mounted
    if (ref.mounted) {
      ref.invalidateSelf();
    }
  }

  Future<void> updateData(SessionMeta sessionMeta) async {
    final appDb = ref.read(appDbProvider);

    await (appDb
          //
          .update(appDb.session)
          ..where((t) => t.id.equals(sessionMeta.id)))
        .write(database.SessionCompanion(name: Value(sessionMeta.name)));

    if (ref.mounted) ref.invalidateSelf();
  }

  Future<void> delete(int id) async {
    final appDb = ref.read(appDbProvider);

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

    if (ref.mounted) ref.invalidateSelf();
  }

  Future<void> reorder(int oldIndex, int newIndex) async {
    final appDb = ref.read(appDbProvider);

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

    if (ref.mounted) ref.invalidateSelf();
  }

  Future<int> getCount() async {
    final appDb = ref.read(appDbProvider);

    final countOfId = appDb.session.id.count();

    final queryResults =
        await (appDb
                //
                .select(appDb.session)
                .addColumns([countOfId]))
            .get();

    final count = queryResults.first.read(countOfId) ?? 0;

    return count;
  }
}
