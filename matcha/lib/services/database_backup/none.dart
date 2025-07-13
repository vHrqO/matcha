import 'dart:typed_data';

interface class DatabaseBackupService {
  Future<void> saveToBackup(String name, Uint8List bytes) async {
    throw UnsupportedError("saveToBackup");
  }

  Future<Uint8List?> exportBackup(String name) async {
    throw UnsupportedError("exportBackup");
  }

  Future<void> deleteBackup(String name) async {
    throw UnsupportedError("deleteBackup");
  }

  Future<void> deleteAllBackups() async {
    throw UnsupportedError("deleteAllBackups");
  }
}
