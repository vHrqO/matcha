import 'package:matcha/repository/database_repo.dart';
import 'package:matcha/repository/settings_repo.dart';

Future<void> initAllPrefs() async {
  await SettingsRepo().initPrefs();

  await TabDbBackupsHistoryRepo().initPrefs();
}
