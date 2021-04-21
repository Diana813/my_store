import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';

class FilePickerBrain {
  static Future<XFile> openTextFile(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'Excel files',
      extensions: ['xlsx', 'csv'],
    );
    return await FileSelectorPlatform.instance
        .openFile(acceptedTypeGroups: [typeGroup]);
  }

  static Future<List<XFile>> openImageFile(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'Image files',
      extensions: ['jpg', 'png'],
    );
    return await FileSelectorPlatform.instance
        .openFiles(acceptedTypeGroups: [typeGroup]);
  }
}
