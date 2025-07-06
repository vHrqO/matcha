import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/repository/settings_repo.dart';

part 'appearance_viewmodel.g.dart';

@riverpod
class AppThemeMode extends _$AppThemeMode {
  @override
  Future<ThemeMode> build() async {
    return await SettingsRepo().getThemeMode();
  }

  Future<void> setThemeMode(ThemeMode themeMode) async {
    await SettingsRepo().setThemeMode(themeMode);

    ref.invalidateSelf();
  }
}
