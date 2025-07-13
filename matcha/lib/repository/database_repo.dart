import 'package:matcha/app/constants.dart' as constants;
import 'package:matcha/model/backup_info.dart';
import 'package:matcha/services/database_backup/database_backup_service.dart';
import 'package:matcha/services/database_file/database_file_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class TabDbBackupsHistoryRepo {
  final _asyncPrefs = SharedPreferencesAsync();

  Future<void> initPrefs() async {
    await _asyncPrefs.setStringList(
      constants.PrefsKey.tabDbBackups,
      constants.PrefsValueDefault.tabDbBackups,
    );
  }

  Future<List<BackupInfo>> getTabDbHistory() async {
    List<BackupInfo> backupInfoList = [];

    final jsonStringList = await _asyncPrefs.getStringList(
      constants.PrefsKey.tabDbBackups,
    );
    if (jsonStringList != null) {
      for (final element in jsonStringList) {
        final jsonString = jsonDecode(element);
        backupInfoList.add(BackupInfo.fromJson(jsonString));
      }

      return backupInfoList;
    } else {
      throw Exception('Prefs not exists , ${constants.PrefsKey.tabDbBackups}');
    }
  }

  Future<void> addTabDbHistory(BackupInfo backupInfo) async {
    final backupInfoList = await getTabDbHistory();

    // Check if the name already exists
    if (backupInfoList.any((item) => item.name == backupInfo.name)) {
      throw Exception('Backup ${backupInfo.name} already exists.');
    }

    backupInfoList.add(backupInfo);

    final jsonList = backupInfoList.map((item) => jsonEncode(item.toJson())).toList();

    await _asyncPrefs.setStringList(constants.PrefsKey.tabDbBackups, jsonList);
  }

  Future<void> updateTabDbHistory(BackupInfo backupInfo) async {
    final backupInfoList = await getTabDbHistory();

    // replace the existing backup history
    final index = backupInfoList.indexWhere((item) => item.name == backupInfo.name);
    if (index != -1) {
      backupInfoList[index] = backupInfo;
    }

    final jsonList = backupInfoList.map((item) => jsonEncode(item.toJson())).toList();

    await _asyncPrefs.setStringList(constants.PrefsKey.tabDbBackups, jsonList);
  }

  Future<void> deleteTabDbHistory(String name) async {
    final List<BackupInfo> backupInfoList = await getTabDbHistory();
    backupInfoList.removeWhere((item) => item.name == name);

    final jsonStringList = backupInfoList
        .map((item) => jsonEncode(item.toJson()))
        .toList();

    await _asyncPrefs.setStringList(constants.PrefsKey.tabDbBackups, jsonStringList);
  }

  Future<void> deleteAllTabDbHistory() async {
    await _asyncPrefs.setStringList(
      constants.PrefsKey.tabDbBackups,
      constants.PrefsValueDefault.tabDbBackups,
    );
  }
}
