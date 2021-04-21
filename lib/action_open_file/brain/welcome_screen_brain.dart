import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/action_mysql/items_table.dart';
import 'package:my_store/action_mysql/mySql.dart';
import 'package:my_store/screens/products_list_screen.dart';
import 'package:my_store/screens/welcome_screen.dart';
import 'package:my_store/utlis/colors.dart';
import 'package:my_store/widgets/popup_dialog.dart';
import 'package:my_store/widgets/popup_files_list.dart';


class WelcomeScreenBrain {
  static getFiles(List<String> files) async {
    var list = await MySql.getTablesList(await WelcomeScreen.connection);
    for (var row in list) {
      files.add(row[2].toString());
      print(row[2].toString());
    }
    return await files;
  }

  static Future<bool> goToProductsList(
      List<Product> items, BuildContext context, String filePath) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (BuildContext context) => new Products_Page(
                productsList: items,
                filePath: filePath,
              )),
    );
    print('go to product list result');
    print(result);
    return result;
  }

  static showAlertIfFileIsWrong(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => PopUpDialog(
            context: context,
            message: 'Plik zawiera nieprawidłowe dane',
            advice: 'Otwórz inny plik'));
  }

  static showAlertFileNotLoadedYet(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) => PopUpDialog(
            context: context,
            message: 'Baza danych jest zajęta zapisywaniem otwartego pliku.',
            advice: 'Spróbuj później'));
  }

  static openFilesList(
      BuildContext context,
      List<String> files,
      bool thereAreItemsInTheList,
      List<Product> items,
      String filePath,
      var currentDocumentLoaded) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PopUpDialogList(
        context: context,
        message: 'Wybierz plik z listy',
        filesList: files,
        listIsNotEmpty: thereAreItemsInTheList,
        listWidget: ListView.builder(
          shrinkWrap: true,
          itemCount: files.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                Icons.done,
                color: MaterialColor(
                    ColorsMyStore.AccentColor, ColorsMyStore.color),
              ),
              title: Text(files.elementAt(index)),
              onTap: () async {
                /* if (currentDocumentLoaded != null && currentDocumentLoaded == false) {
                  showAlertFileNotLoadedYet(context);
                  print('current document loaded from welcome_brain');
                  print(currentDocumentLoaded);
                } else {*/

                items = await ItemsTable.readItemsDataFromDBTable(
                    await WelcomeScreen.connection, files.elementAt(index));
                Navigator.pop(context);
                goToProductsList(items, context, null);
                /*}*/
              }, // Handle your onTap here.
            );
          },
        ),
      ),
    );
  }
}
