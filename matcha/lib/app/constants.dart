import 'package:flutter/widgets.dart';

//
enum SortOrder {
  custom("Custom"),
  ascending("Ascending"),
  descending("Descending");

  final String uiName;

  const SortOrder(this.uiName);
}

enum SelectMethod {
  selectAll("Select All"),
  invertSelection("Invert Selection"),
  clearSelection("Clear Selection");

  final String uiName;

  const SelectMethod(this.uiName);
}

class AnimationSettings {
  static const duration = Duration(milliseconds: 300);
  static const curve = Curves.easeInOutCubic;
}

class DatabaseName {
  static const String tabDatabase = "tab_database";
}

/// Preferences key
class PrefsKey {
  static const String firstTimeRun = "first_time_run";

  static const String themeMode = "theme_mode";

  static const String tabDbBackups = "tab_db_backups";
}

/// Preferences default value
class PrefsValueDefault {
  static const bool firstTimeRun = false;

  static const String themeMode = "dark";

  static const List<String> tabDbBackups = [];
}
