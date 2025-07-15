import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'package:matcha/app/constants.dart' as constants;

part 'database.g.dart';

@DriftDatabase(
  include: {
    './tab_tables/tab_tables.drift',
    './tab_tables/session_list_repo_queries.drift',
    './tab_tables/session_repo_queries.drift',
  },
)
class TabDatabase extends _$TabDatabase {
  // After generating code, this class needs to define a `schemaVersion` getter
  // and a constructor telling drift where the database should be stored.
  // These are described in the getting started guide: https://drift.simonbinder.eu/setup/
  TabDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: constants.DatabaseName.tabDatabase,
      native: const DriftNativeOptions(
        // By default, `driftDatabase` from `package:drift_flutter` stores the
        // database files in `getApplicationDocumentsDirectory()`.
        databaseDirectory: getApplicationSupportDirectory,
      ),
      // If you need web support, see https://drift.simonbinder.eu/platforms/web/
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
        onResult: (WasmDatabaseResult result) {
          // print('Wasm database result: $result');
        },
      ),
    );
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        // enable foreign key references for sqlite3
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }
}
