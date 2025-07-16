import 'dart:typed_data';

import 'package:sembast/sembast.dart' as sembast;
import 'package:sembast/blob.dart' as sembast_blob;
import 'package:sembast_web/sembast_web.dart' as sembast_web;

import 'package:matcha/services/database_backup/none.dart' as none;
import 'package:matcha/app/constants.dart' as constants;

class DbBackupSingleton {
  // singleton cache
  static DbBackupSingleton? _instance;

  // database connection
  late final sembast.Database db;

  // lazy init
  DbBackupSingleton._internal();

  static Future<DbBackupSingleton> get instance async {
    if (_instance == null) {
      _instance = DbBackupSingleton._internal();

      _instance!.db = await sembast_web.databaseFactoryWeb.openDatabase(
        constants.DatabaseName.databaseBackup,
      );
    }

    return _instance!;
  }

  static Future<void> release() async {
    // if the instance exists, close database
    await _instance?.db.close();

    // drop the cache
    _instance = null;
  }
}

class DatabaseBackupService implements none.DatabaseBackupService {
  //
  Future<(sembast.Database, sembast.StoreRef<String, sembast_blob.Blob>)>
  _getDbAndStore(constants.DatabaseType type) async {
    final db = (await DbBackupSingleton.instance).db;
    final store = sembast.StoreRef<String, sembast_blob.Blob>(type.dbName);

    return (db, store);
  }

  @override
  Future<void> saveToBackup(
    constants.DatabaseType type,
    String name,
    Uint8List bytes,
  ) async {
    final (db, store) = await _getDbAndStore(type);

    // Store data
    await store.record(name).put(db, sembast_blob.Blob(bytes));

    await DbBackupSingleton.release();
  }

  @override
  Future<Uint8List?> exportBackup(constants.DatabaseType type, String name) async {
    final (db, store) = await _getDbAndStore(type);

    // read data
    final bytes = (await store.record(name).get(db))?.bytes;

    await DbBackupSingleton.release();

    if (bytes != null) {
      return bytes;
    }

    return null;
  }

  @override
  Future<void> deleteBackup(constants.DatabaseType type, String name) async {
    final (db, store) = await _getDbAndStore(type);

    // delete data
    await store.record(name).delete(db);

    await DbBackupSingleton.release();
  }

  @override
  Future<void> deleteAllBackups(constants.DatabaseType type) async {
    final (db, store) = await _getDbAndStore(type);

    // delete all data
    await store.delete(db);

    await DbBackupSingleton.release();
  }
}
