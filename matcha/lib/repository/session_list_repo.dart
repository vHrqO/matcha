import 'package:riverpod_annotation/riverpod_annotation.dart';

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

    final List<database.SessionData> queryResult = await appDb
        .select(appDb.session)
        .get();

    final List<SessionMeta> data = queryResult
        .map((item) => SessionMeta(id: item.id, name: item.name))
        .toList();

    return data;
  }

  Future<void> add(String name) async {
    final appDb = ref.read(appDbProvider);

    await appDb
        .into(appDb.session)
        .insert(database.SessionCompanion.insert(name: name));

    ref.invalidateSelf();
  }

  Future<void> updateData(SessionMeta sessionMeta) async {
    final appDb = ref.read(appDbProvider);

    await appDb
        .update(appDb.session)
        .replace(database.SessionData(id: sessionMeta.id, name: sessionMeta.name));

    ref.invalidateSelf();
  }

  Future<void> delete(int id) async {
    final appDb = ref.read(appDbProvider);

    await (appDb.delete(appDb.session)..where((t) => t.id.equals(id))).go();

    ref.invalidateSelf();
  }
}
