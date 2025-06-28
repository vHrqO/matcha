import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:matcha/database/database.dart' as database;
import 'package:matcha/mock_data/existing_tags.dart';

part 'database_viewmodel.g.dart';

@riverpod
class TabDb extends _$TabDb {
  late database.TabDatabase _database;

  @override
  database.TabDatabase build() {
    // init database
    _database = database.TabDatabase();

    // When the state is destroyed, close the database
    ref.onDispose(() {
      _database.close();
    });

    return _database;
  }
}

@riverpod
Future<List<String>> existingTags(Ref ref) async {
  // read from database
  // no need to database , if save sussessful,
  // next time will read from database
  final tags = mockExistingTags;

  return tags;
}
