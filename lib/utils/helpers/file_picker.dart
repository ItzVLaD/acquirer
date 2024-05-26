import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';

class MyFilePicker {
  static Future<(Uint8List?, String?)> pickAFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png'],
    );

    Uint8List? file;
    String? fileName;

    if (result != null) {
      file = result.files.first.bytes!;
      fileName = result.files.first.name;
    } else {}

    return (file, fileName);
  }
}
