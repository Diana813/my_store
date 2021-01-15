import 'package:file_selector/file_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';

class FilePickerBrain{

  static Future<XFile> openTextFile(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'Excel files',
      extensions: ['xlsx', 'xls'],
    );
    return await FileSelectorPlatform.instance
        .openFile(acceptedTypeGroups: [typeGroup]);
  }

}