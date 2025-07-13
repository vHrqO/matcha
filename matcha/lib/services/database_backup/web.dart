import 'dart:typed_data';

import 'package:idb_shim/idb.dart' as idb_shim;
import 'package:idb_shim/idb_browser.dart' as idb_shim_browser;

import 'package:matcha/services/database_backup/none.dart' as none;

class DatabaseBackupService implements none.DatabaseBackupService {
  Future<({idb_shim.Database db, String storeName})> _openDbBackup() async {
    final idbFactory = idb_shim_browser.getIdbFactory();
    if (idbFactory == null) {
      throw Exception('IndexedDB is not supported');
    }

    const String storeName = "tab_db_backup";

    // open the database
    final db = await idbFactory.open(
      "backup",
      version: 1,
      onUpgradeNeeded: (idb_shim.VersionChangeEvent event) {
        final db = event.database;
        // create the store
        db.createObjectStore(storeName, autoIncrement: true);
      },
    );

    return (db: db, storeName: storeName);
  }

  @override
  Future<void> saveToBackup(String name, Uint8List bytes) async {
    final (db: db, storeName: storeName) = await _openDbBackup();

    // put data
    final transaction = db.transaction(storeName, "readwrite");
    final store = transaction.objectStore(storeName);
    await store.put(bytes, name);
    await transaction.completed;

    db.close();
  }

  @override
  Future<Uint8List?> exportBackup(String name) async {
    final (db: db, storeName: storeName) = await _openDbBackup();

    // read some data
    final transaction = db.transaction(storeName, "readonly");
    final store = transaction.objectStore(storeName);
    final bytes = await store.getObject(name);
    await transaction.completed;

    db.close();

    if (bytes != null) {
      return bytes as Uint8List;
    }

    return null;
  }

  @override
  Future<void> deleteBackup(String name) async {
    final (db: db, storeName: storeName) = await _openDbBackup();

    // delete data
    final transaction = db.transaction(storeName, "readwrite");
    final store = transaction.objectStore(storeName);
    await store.delete(name);
    await transaction.completed;

    db.close();
  }

  @override
  Future<void> deleteAllBackups() async {
    final (db: db, storeName: storeName) = await _openDbBackup();

    // delete all data
    final transaction = db.transaction(storeName, "readwrite");
    final store = transaction.objectStore(storeName);
    await store.clear();
    await transaction.completed;

    db.close();
  }
}

//
Future<void> altDeleteDatabase(String name) async {
  final idbFactory = idb_shim_browser.getIdbFactory();
  if (idbFactory == null) {
    throw Exception('IndexedDB is not supported');
  }



  // delete the database
  await idbFactory.deleteDatabase(
    name,
    onBlocked: (event) {
      print('Database deletion blocked: $event');
    },
  );
}
