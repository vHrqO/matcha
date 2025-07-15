import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/model/backup_info.dart';
import 'package:matcha/repository/database_repo.dart';
import 'package:matcha/services/database_backup/database_backup_service.dart';
import 'package:matcha/services/database_file/database_file_service.dart';
import 'package:matcha/services/file_service.dart';
import 'package:matcha/app/constants.dart' as constants;

part 'data_viewmodel.g.dart';

@riverpod
class ImportExportDb extends _$ImportExportDb {
  @override
  Future<void> build() async {
    //
  }

  Future<void> import() async {
    final file = await FileService().pickFile(["db"]);
    if (file == null) {
      return;
    }

    await DatabaseFileService().importDatabase(
      ref,
      constants.DatabaseName.tabDatabase,
      file,
    );
  }

  Future<void> export() async {
    final file = await DatabaseFileService().exportDatabase(
      constants.DatabaseName.tabDatabase,
    );
    if (file == null) {
      throw Exception('Failed to export database');
    }

    await FileService().saveFile("${constants.DatabaseName.tabDatabase}.db", file);
  }
}

@riverpod
class SafetyBackupsList extends _$SafetyBackupsList {
  @override
  Future<List<BackupInfo>> build() async {
    return await TabDbBackupsHistoryRepo().getTabDbHistory();
  }

  Future<void> addBackup({bool isManual = false}) async {
    final backupTime = DateTime.now();
    final backupName = backupTime.toIso8601String();

    // add backup
    final file = await DatabaseFileService().exportDatabase(
      constants.DatabaseName.tabDatabase,
    );
    if (file == null) {
      throw Exception('Failed to export database');
    }

    await DatabaseBackupService().saveToBackup(backupName, file);

    // add history
    await TabDbBackupsHistoryRepo().addTabDbHistory(
      BackupInfo(
        name: backupName,
        backupType: isManual ? "manual" : "auto",
        saveTime: backupTime,
      ),
    );

    // if more than 3 backups, delete the oldest one
    final backups = await TabDbBackupsHistoryRepo().getTabDbHistory();
    if (backups.length > 3) {
      await TabDbBackupsHistoryRepo().deleteTabDbHistory(backups.first.name);
      await DatabaseBackupService().deleteBackup(backups.first.name);
    }

    ref.invalidateSelf();
  }

  Future<void> restoreBackup(BackupInfo backupInfo) async {
    // get backup
    final file = await DatabaseBackupService().exportBackup(backupInfo.name);
    if (file == null) {
      throw Exception('Failed to get backup');
    }

    // import database
    await DatabaseFileService().importDatabase(
      ref,
      constants.DatabaseName.tabDatabase,
      file,
    );

    ref.invalidateSelf();
  }

  Future<void> deleteBackup(BackupInfo backupInfo) async {
    // delete history
    await TabDbBackupsHistoryRepo().deleteTabDbHistory(backupInfo.name);

    // delete backups
    await DatabaseBackupService().deleteBackup(backupInfo.name);

    ref.invalidateSelf();
  }

  Future<void> deleteAllBackup() async {
    // delete all history
    await TabDbBackupsHistoryRepo().deleteAllTabDbHistory();

    // delete all backups
    await DatabaseBackupService().deleteAllBackups();

    ref.invalidateSelf();
  }

  Future<void> saveBackup(BackupInfo backupInfo) async {
    // export database
    final file = await DatabaseFileService().exportDatabase(
      constants.DatabaseName.tabDatabase,
    );
    if (file == null) {
      throw Exception('Failed to export database');
    }

    await FileService().saveFile("${constants.DatabaseName.tabDatabase}.db", file);
  }
}
