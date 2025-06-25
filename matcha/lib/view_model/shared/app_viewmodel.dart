import 'package:riverpod_annotation/riverpod_annotation.dart';

//
import 'package:matcha/database/database.dart' as database;

part 'app_viewmodel.g.dart';

@riverpod
class RightSideOpened extends _$RightSideOpened {
  bool _isOpen = true;

  @override
  bool build() {
    return _isOpen;
  }

  void toggle([bool? value]) {
    if (value == null) {
      // toggle if null
      _isOpen = !_isOpen;
    } else {
      _isOpen = value;
    }

    state = _isOpen;
  }
}

@riverpod
class TabGroupOpened extends _$TabGroupOpened {
  bool _isOpen = false;

  @override
  bool build() {
    return _isOpen;
  }

  void toggle([bool? value]) {
    if (value == null) {
      // toggle if null
      _isOpen = !_isOpen;
    } else {
      _isOpen = value;
    }

    state = _isOpen;
  }
}

//
@riverpod
class AppDb extends _$AppDb {
  late database.AppDatabase _database;

  @override
  database.AppDatabase build() {
    // init database
    _database = database.AppDatabase();

    // When the state is destroyed, close the database
    ref.onDispose(() {
      _database.close();
    });

    return _database;
  }
}
