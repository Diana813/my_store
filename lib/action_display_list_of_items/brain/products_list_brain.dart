import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/action_mysql/items_table.dart';
import 'package:my_store/action_mysql/mySql.dart';
import 'package:my_store/action_mysql/prices_table.dart';
import 'package:my_store/screens/allegro_form_screen.dart';
import 'package:my_store/screens/welcome_screen.dart';
import 'package:my_store/widgets/popup_dialog.dart';
import 'package:mysql1/mysql1.dart';


class ProductsListBrain {
  static String displayMinPrize(
      String euro, String myRetail, String myMargin, String myTotalRetail) {
    if (euro != '' &&
        myRetail != '' &&
        myMargin != '' &&
        myTotalRetail != '' &&
        euro != null &&
        myRetail != null &&
        myMargin != null &&
        myTotalRetail != null &&
        euro != 'null' &&
        myRetail != 'null' &&
        myMargin != 'null' &&
        myTotalRetail != 'null') {
      euro = euro.replaceAll(',', '.');
      myRetail = myRetail.replaceAll(',', '.');
      myMargin = myMargin.replaceAll(',', '.');
      myTotalRetail = myTotalRetail.replaceAll(',', '.');

      double euroRate = double.parse(euro);
      double retail = double.parse(myRetail);
      double margin = double.parse(myMargin);
      double totalRetail = double.parse(myTotalRetail);

      String minPrize =
          (totalRetail * (retail / 100) * euroRate * (margin / 100))
              .toStringAsFixed(2);
      return minPrize;
    } else {
      return '';
    }
  }

  static showAlertBeforeClosing(BuildContext context, String tableName) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PopUpDialog(
        context: context,
        message:
            'Plik, na którym pracujesz nie jest jeszcze w całości dodany do bazy danych.',
        advice: 'Jeśli teraz zamkniesz aplikację, plik nie zostanie zapisany.',
        flatButton: FlatButton(
          onPressed: () async {
            await MySql.seekAndDestroy_query(
                await WelcomeScreen.connection, tableName);
            closeApp();
          },
          textColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Zamknij mimo to'),
          ),
        ),
      ),
    );
  }

  static closeApp() async {
    MySqlConnection conn = await WelcomeScreen.connection;
    await conn.close();
    appWindow.close();
  }

  static createDBExcelTable(String filePath, List<Product> items) async {
    if (filePath != null && filePath != '' && filePath != 'a') {
      return await ItemsTable.addItemsToDb(
          await WelcomeScreen.connection, items);
      /*return await MySql.checkIfAllExcelDataAreLoadedToDB(
          items.elementAt(0).shipmentDate.substring(0, 10).replaceAll('-', '_'),
          await WelcomeScreen.connection,
          items);*/
    }
  }

  static createDBPricesTable() async {
    PricesTable.createTablePrices(await WelcomeScreen.connection);
  }

  static Future<bool> goToAllegroScreen(
      List<Product> items, BuildContext context, int index) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => new AllegroForm(
                product: items.elementAt(index),
              )),
    );
    print('go to allegro screen result');
    print(result);
    return result;
  }
}