import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:matcha/view_model/shared/database_viewmodel.dart';
import 'package:matcha/services/database_file/none.dart' as none;

class DatabaseFileService implements none.DatabaseFileService {
  @override
  Future<Uint8List?> exportDatabase(String databaseName) async {
    print("exportDatabase");

    return Uint8List(0);
  }

  @override
  Future<void> importDatabase(Ref ref, String databaseName, Uint8List bytes) async {
    print("importDatabase");

    // Close the current database connection
    await ref.read(tabDbProvider.notifier).close();

    // restore connection
    await ref.read(tabDbProvider.notifier).connect();
  }

  @override
  Future<List<String>> getAvailableApis(String databaseName) async {
    print("getAvailableApis");

    return [];
  }
}
