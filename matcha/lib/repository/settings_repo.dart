import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:matcha/app/constants.dart' as constants;

class SettingsRepo {
  final _asyncPrefs = SharedPreferencesAsync();

  Future<void> initPrefs() async {
    await _asyncPrefs.setBool(
      constants.PrefsKey.firstTimeRun,
      constants.PrefsValueDefault.firstTimeRun,
    );
    await _asyncPrefs.setString(
      constants.PrefsKey.themeMode,
      constants.PrefsValueDefault.themeMode,
    );
  }

  Future<bool> isFirstTimeRun() async {
    final firstTimeRun = await _asyncPrefs.getBool(constants.PrefsKey.firstTimeRun);

    // first Time Run , in theory dont has key
    if (firstTimeRun == null || firstTimeRun) {
      return true;
    }

    return false;
  }

  Future<ThemeMode> getThemeMode() async {
    final themeMode = await _asyncPrefs.getString(constants.PrefsKey.themeMode);

    switch (themeMode) {
      case "system":
        return ThemeMode.system;
      case "light":
        return ThemeMode.light;
      case "dark":
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await _asyncPrefs.setString(constants.PrefsKey.themeMode, themeMode.name);
  }

  
}
