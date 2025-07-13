import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/wasm.dart' as drift_wasm;
import 'package:sqlite3/wasm.dart' as sqlite3_wasm;
import 'package:matcha/services/database_backup/web.dart' show altDeleteDatabase;

import 'package:matcha/view_model/shared/database_viewmodel.dart';
import 'package:matcha/services/database_file/none.dart' as none;

class DatabaseFileService implements none.DatabaseFileService {
  @override
  Future<Uint8List?> exportDatabase(String databaseName) async {
    final info = await drift_wasm.WasmDatabase.probe(
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
      databaseName: databaseName,
    );

    if (info.existingDatabases.isEmpty) {
      throw Exception('Database does not exist');
    }

    // check database api
    // to_do: implement OPFS export
    final isIndexedDb = info.existingDatabases.any((element) {
      return element.$1 == drift_wasm.WebStorageApi.indexedDb;
    });

    // export
    if (isIndexedDb) {
      final blob = await info.exportDatabase((
        drift_wasm.WebStorageApi.indexedDb,
        databaseName,
      ));

      return blob;
    }

    return null;
  }

  @override
  Future<void> importDatabase(Ref ref, String databaseName, Uint8List bytes) async {
    final info = await drift_wasm.WasmDatabase.probe(
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
      databaseName: databaseName,
    );

    if (info.existingDatabases.isEmpty) {
      throw Exception('Database does not exist');
    }

    // check database api
    // to_do: implement OPFS export
    final isIndexedDb = info.existingDatabases.any((element) {
      return element.$1 == drift_wasm.WebStorageApi.indexedDb;
    });

    // Close the current database connection
    await ref.read(tabDbProvider.notifier).close();
    // final tabDb = await ref.read(tabDbProvider.future);
    // await tabDb.close();

    // Delete Database
    //  to_do : bug?
    await info.deleteDatabase((drift_wasm.WebStorageApi.indexedDb, databaseName));

    // import
    if (isIndexedDb) {
      final tmp = await info.open(
        drift_wasm.WasmStorageImplementation.sharedIndexedDb,
        databaseName,
        initializeDatabase: () async {
          return bytes;
        },
      );

      // await tmp.close();
    }

    // restore connection
    await ref.read(tabDbProvider.notifier).connect();
  }

  @override
  Future<List<String>> getAvailableApis(String databaseName) async {
    final info = await drift_wasm.WasmDatabase.probe(
      sqlite3Uri: Uri.parse('sqlite3.wasm'),
      driftWorkerUri: Uri.parse('drift_worker.js'),
      databaseName: databaseName,
    );

    List<String> availableApis = info.availableStorages.map((e) => e.name).toList();

    return availableApis;
  }
}
