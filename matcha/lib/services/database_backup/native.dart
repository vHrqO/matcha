import 'dart:typed_data';

import 'package:matcha/app/constants.dart' as constants;
import 'package:matcha/services/database_backup/none.dart' as none;

class DatabaseBackupService implements none.DatabaseBackupService {
  @override
  Future<void> saveToBackup(
    constants.DatabaseType type,
    String name,
    Uint8List bytes,
  ) async {
    print("saveToBackup");
  }

  @override
  Future<Uint8List?> exportBackup(constants.DatabaseType type, String name) async {
    print("exportBackup");

    return Uint8List(0);
  }

  @override
  Future<void> deleteBackup(constants.DatabaseType type, String name) async {
    print("deleteBackup");
  }

  @override
  Future<void> deleteAllBackups(constants.DatabaseType type) async {
    print("deleteAllBackups");
  }
}
