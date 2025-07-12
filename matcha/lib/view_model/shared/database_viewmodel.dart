import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/database/database.dart' as database;

part 'database_viewmodel.g.dart';

@riverpod
class TabDb extends _$TabDb {
  late database.TabDatabase _database;

  bool _canConnect = true;
  Completer<void> _waitConnect = Completer<void>();

  @override
  Future<database.TabDatabase> build() async {
    // Wait until can connect , default is true
    if (!_waitConnect.isCompleted && _canConnect) {
      _waitConnect.complete();
    }
    await _waitConnect.future;

    // init database
    _database = database.TabDatabase();

    // When the state is destroyed, close the database
    ref.onDispose(() async {
      await _database.close();
    });

    return _database;
  }

  Future<void> close() async {
    await _database.close();

    _canConnect = false;
    if (_waitConnect.isCompleted) {
      _waitConnect = Completer<void>();
    }

    ref.invalidateSelf();
  }

  Future<void> connect() async {
    _canConnect = true;
    if (!_waitConnect.isCompleted) {
      _waitConnect.complete();
    }

    ref.invalidateSelf();
  }
}

@riverpod
Future<List<String>> existingTags(Ref ref) async {
  final tabDb = await ref.watch(tabDbProvider.future);

  final tags = await tabDb.getAllDistinctTags().get();

  return tags;
}
