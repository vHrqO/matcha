import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/database/database.dart' as database;

part 'database_viewmodel.g.dart';

class TabDbSingleton {
  // singleton cache
  static TabDbSingleton? _instance;

  // database connection
  late final database.TabDatabase db;

  // lazy init
  factory TabDbSingleton() => _instance ??= TabDbSingleton._internal();

  TabDbSingleton._internal() {
    db = database.TabDatabase();
  }

  static Future<void> release() async {
    // if the instance exists, close database
    await _instance?.db.close();

    // drop the cache
    _instance = null;
  }
}

@riverpod
class TabDb extends _$TabDb {
  bool _canConnect = true;
  Completer<void> _waitConnect = Completer<void>();

  @override
  Future<database.TabDatabase> build() async {
    // block until can connect , default is true
    if (!_waitConnect.isCompleted && _canConnect) {
      _waitConnect.complete();
    }
    await _waitConnect.future;

    // init database
    final db = TabDbSingleton().db;

    return db;
  }

  Future<void> close() async {
    await TabDbSingleton.release();

    _canConnect = false;

    // block build() next time
    if (_waitConnect.isCompleted) {
      _waitConnect = Completer<void>();
    }

    ref.invalidateSelf();
  }

  Future<void> connect() async {
    _canConnect = true;

    // unblock waiting
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
