import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/action_go_to_another_screen/display_popup.dart';
import 'package:my_store/action_mysql/mySql.dart';
import 'package:my_store/screens/products_list_screen.dart';
import 'package:my_store/widgets/popup_dialog.dart';

class WelcomeScreenBrain {
  static getFiles() async {
    List<String> files = [];
    var list = await MySql.getTablesList();
    if (list == null) {
      return files;
    }
    for (var row in list) {
      files.add(row[2].toString());
    }
    return files;
  }

  static Future<bool> goToProductsList(
      List<Product> items,
      BuildContext context,
      String filePath,
      String tableName,
      updateState) async {
    DisplayPopUp.stopDownloadingImages = false;
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => new Products_Page(
                productsList: items,
                filePath: filePath,
                itemsTableName: tableName,
              )),
    ).then((value) => updateState());
    return result;
  }

  static showAlertIfFileIsWrong(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => PopUpDialog(
              message: 'Plik zawiera nieprawidłowe dane',
              advice: 'Otwórz inny plik',
            ));
  }

  static showAlertFileNotLoadedYet(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => PopUpDialog(
              message: 'Baza danych jest zajęta zapisywaniem otwartego pliku.',
              advice: 'Spróbuj później',
            ));
  }
}
