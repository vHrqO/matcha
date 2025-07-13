import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:file_picker/file_picker.dart';

class FileService {
  Future<String?> saveFile(String fileName, Uint8List bytes) async {
    final outputPath = await FilePicker.platform.saveFile(
      dialogTitle: 'Save to file :',
      fileName: fileName,
      bytes: bytes,
    );

    return outputPath;
  }

  Future<Uint8List?> pickFile(List<String> allowedExtensions) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: allowedExtensions,
    );

    if (result != null) {
      final xFile = XFile(result.files.single.path!);
      return await xFile.readAsBytes();
    }

    return null;
  }
}
