import 'dart:typed_data';

import 'package:matcha/services/database_backup/none.dart' as none;

class DatabaseBackupService implements none.DatabaseBackupService {
  @override
  Future<void> saveToBackup(String name, Uint8List bytes) async {
    print("saveToBackup");
  }

  @override
  Future<Uint8List?> exportBackup(String name) async {
    print("exportBackup");

    return Uint8List(0);
  }

  @override
  Future<void> deleteBackup(String name) async {
    print("deleteBackup");
  }

  @override
  Future<void> deleteAllBackups() async {
    print("deleteAllBackups");
  }
}
