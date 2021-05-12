import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_display_list_of_items/brain/products_list_brain.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/action_mysql/items_table.dart';
import 'package:my_store/action_open_file/brain/welcome_screen_brain.dart';
import 'package:my_store/widgets/popup_dialog.dart';

class DisplayList {
  static Future<List<Product>> displayList(
      String filePath, String tableName, List<Product> productList) async {
    //jeżeli otwieramy z pliku na dysku
    if (filePath != null) {
      //jeżeli ten plik jest już w bazie danych to otwórz z bazy danych, żeby wyświetlić obrazki
      List<String> files = await WelcomeScreenBrain.getFiles();
      if (files.isNotEmpty && files != null) {
        for (String file in files) {
          if (file == ProductsListBrain.getItemsTableName(productList)) {
            return await ItemsTable.readItemsDataFromDBTable(tableName);
          }
        }
      }
      return productList;
    } else {
      //jeżeli otwieramy z bazy danych
      return await ItemsTable.readItemsDataFromDBTable(tableName);
    }
  }

  static displayMessageNoConnection(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PopUpDialog(
        message: message,
      ),
    );
  }

  static displayImages(String tableName) async {
    await ItemsTable.readItemsDataFromDBTable(tableName);
  }
}
