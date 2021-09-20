import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/screens/welcome_screen.dart';
import 'package:mysql1/mysql1.dart';

import 'mySql.dart';

class ItemsTable {
  static const db = MySql.db;

  static createTableItems(MySqlConnection connection, String tableName) async {
    if (tableName == null) {
      return;
    }
    try {
      await connection.query(
          'CREATE TABLE IF NOT EXISTS $tableName (id int NOT NULL AUTO_INCREMENT PRIMARY KEY,shipmentDate TEXT, ASIN TEXT, EAN TEXT, name TEXT, euro TEXT, LPN TEXT, at_auction bool, sold bool, image_url TEXT)');
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      print('tworzę tablę');
      await connection.query(
          'CREATE TABLE IF NOT EXISTS $tableName (id int NOT NULL AUTO_INCREMENT PRIMARY KEY,shipmentDate TEXT, ASIN TEXT, EAN TEXT, name TEXT, euro TEXT, LPN TEXT, at_auction bool, sold bool, image_url TEXT)');
    }
  }

  static readItemsDataFromDBTable(String tableName) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    List<Product> dbData = [];
    try {
      var resultItems = await connection.query("SELECT * FROM $tableName");
      for (var row in resultItems) {
        final product = Product(
          imageUrl: row[9].toString(),
          at_the_auction: row[7] == 1 ? true : false,
          sold: row[8] == 1 ? true : false,
          shipmentDate: row[1].toString(),
          ASIN: row[2].toString(),
          EAN: row[3].toString(),
          name: row[4].toString(),
          totalRetail: row[5].toString(),
          LPN: row[6].toString(),
        );
        dbData.add(product);
      }
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      print('odczytuję dane z tabeli items');
      var resultItems = await connection.query("SELECT * FROM $tableName");
      for (var row in resultItems) {
        final product = Product(
          imageUrl: row[9].toString(),
          at_the_auction: row[7] == 1 ? true : false,
          sold: row[8] == 1 ? true : false,
          shipmentDate: row[1].toString(),
          ASIN: row[2].toString(),
          EAN: row[3].toString(),
          name: row[4].toString(),
          totalRetail: row[5].toString(),
          LPN: row[6].toString(),
        );
        dbData.add(product);
      }
    }
    return dbData;
  }

  static checkifTableIsInDb(String tableName) async {
    if (tableName == null) {
      return true;
    }
    MySqlConnection connection = await WelcomeScreen.connection;
    //jeśli ta tabela już istnieje to nie powinno się do niej dodawać nowych danych
    var tableAlreadyExists = await MySql.tableExists(connection, tableName);
    if (tableAlreadyExists) {
      return true;
    }

    //sprawdza połączenie i tworzy tabelę jeśli nie istnieje
    await createTableItems(connection, tableName);
    return false;
  }

  static addItemToDb(List<Product> items, String tableName, int i) async {
    /*if (tableName == null) {
      return;
    }
    MySqlConnection connection = await WelcomeScreen.connection;
    //jeśli ta tabela już istnieje to nie powinno się do niej dodawać nowych danych
    var tableAlreadyExists = await MySql.tableExists(connection, tableName);
    if (tableAlreadyExists == null) {
      return;
    }
    if (tableAlreadyExists) {
      return true;
    }

    //sprawdza połączenie i tworzy tabelę jeśli nie istnieje
    await createTableItems(connection, tableName);*/

    MySqlConnection connection = await WelcomeScreen.connection;
    if(connection == null){
      return;
    }

    await connection.query(
        'insert into $tableName (shipmentDate, ASIN, EAN, name, euro, LPN,at_auction, sold) values (?,?,?,?,?,?,?,?)',
        [
          items.elementAt(i).shipmentDate,
          items.elementAt(i).ASIN,
          items.elementAt(i).EAN.split('.')[0],
          items.elementAt(i).name,
          items.elementAt(i).totalRetail,
          items.elementAt(i).LPN,
          items.elementAt(i).at_the_auction,
          items.elementAt(i).sold,
        ]);
  }

  static deleteTable(String tableName) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    try {
      await connection.query("DROP TABLE IF EXISTS $tableName");
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      await connection.query("DROP TABLE IF EXISTS $tableName");
    }
  }

  static insertDataToCheckBoxesAtAuction(
      tableName, String LPN, bool atAuction) async {
    insertData(tableName, LPN, atAuction, 'at_auction');
  }

  static insertData(
      String tableName, String LPN, bool isChecked, String columnName) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    //sprawdza połączenie i tworzy tabelę jeśli nie istnieje
    //createTableItems(tableName, connection);
    var result;
    try {
      result = await connection.query(
          "SELECT $columnName FROM $tableName WHERE LPN = '$LPN' ORDER BY id DESC LIMIT 1");
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      result = await connection.query(
          "SELECT $columnName FROM $tableName WHERE LPN = '$LPN' ORDER BY id DESC LIMIT 1");
    }
    if (result.toString() == '()') {
      result = await connection.query(
          "insert into $tableName (LPN, $columnName) values (?,?)",
          [LPN, isChecked]);
    } else {
      result = await connection.query(
          "update $tableName set $columnName = $isChecked where LPN = '$LPN'");
    }
  }

  static insertDataToCheckBoxesSold(tableName, String LPN, bool sold) async {
    insertData(tableName, LPN, sold, 'sold');
  }

  static insertImageUrlData(tableName, int index, String url) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    try {
      await connection.query(
          "update $tableName set image_url = '$url' where id = '$index'");
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      await connection.query(
          "update $tableName set image_url = '$url' where id = '$index'");
    }
  }
}
