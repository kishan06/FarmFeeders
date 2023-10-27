import 'dart:io';

import 'package:file_picker/file_picker.dart';


class FilePickerMethod {
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'jpg',
        'jpeg',
        'png',
        'pdf'
      ], // Define the allowed file types
    );

    if (result != null) {
      return File(result.files.single.path!);
    } else {
      return null;
    }
  }
}
