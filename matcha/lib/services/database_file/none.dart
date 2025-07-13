import 'dart:typed_data';

import 'package:flutter_riverpod/flutter_riverpod.dart';

interface class DatabaseFileService {
  Future<Uint8List?> exportDatabase(String databaseName) async {
    throw UnsupportedError("exportDatabase");
  }

  Future<void> importDatabase(Ref ref, String databaseName, Uint8List bytes) async {
    throw UnsupportedError("importDatabase");
  }

  Future<List<String>> getAvailableApis(String databaseName) async {
    throw UnsupportedError("getAvailableApis");
  }
}
