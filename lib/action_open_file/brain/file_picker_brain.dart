
import 'package:filepicker_windows/filepicker_windows.dart';

class FilePickerBrain {
  static openText() {
    final file = OpenFilePicker()
      ..filterSpecification = {
        'Excel file (*.xlsx; *.csv)': '*.xlsx;*.csv',
      };
    final result = file.getFile();
    if (result != null) {
      return result.path;
    }
  }

  static openImageFile() {
    final file = OpenFilePicker()
      ..filterSpecification = {'Image files (*.jpg; *.png)': '*.jpg; *.png'};

    final result = file.getFile();
    if (result != null) {
      return result.path;
    }
  }
}
