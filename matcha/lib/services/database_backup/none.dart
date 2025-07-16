import 'dart:typed_data';

import 'package:matcha/app/constants.dart' as constants;

interface class DatabaseBackupService {
  Future<void> saveToBackup(
    constants.DatabaseType type,
    String name,
    Uint8List bytes,
  ) async {
    throw UnsupportedError("saveToBackup");
  }

  Future<Uint8List?> exportBackup(constants.DatabaseType type, String name) async {
    throw UnsupportedError("exportBackup");
  }

  Future<void> deleteBackup(constants.DatabaseType type, String name) async {
    throw UnsupportedError("deleteBackup");
  }

  Future<void> deleteAllBackups(constants.DatabaseType type) async {
    throw UnsupportedError("deleteAllBackups");
  }
}
