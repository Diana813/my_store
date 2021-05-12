import 'package:my_store/screens/welcome_screen.dart';
import 'package:mysql1/mysql1.dart';

import 'mySql.dart';

class PricesTable {
  static const db = MySql.db;

  static createTablePrices(MySqlConnection connection) async {
    var result;
    try {
      result = createTable(connection);
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      print('tworzę tabelę prices');
      if (connection == null) {
        return;
      }
      result = createTable(connection);
    }
    return result;
  }

  static createTable(MySqlConnection connection) async {
    await connection.query(
        'CREATE TABLE IF NOT EXISTS prices (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, euro DOUBLE,  price DOUBLE, margin DOUBLE, date DATE, shipmentDate TEXT)');
  }

  static insertDataToPrices(String euro, String price, String margin,
      String date, String shipment) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    var result;
    if (MySql.tableExists(connection, 'prices') == false) {
      //tworzy tabelę jeśli nie istnieje i sprawdza połączenie
      result = await createTablePrices(connection);
    }
    if (result.toString() != '()') {
      await insertData(connection, euro, price, margin, date, shipment);
    }
  }

  static insertData(MySqlConnection connection, String euro, String price,
      String margin, String date, String shipment) async {
    try {
      await connection.query(
          'insert into prices (euro, price, margin, date, shipmentDate) values (?,?,?,?,?)',
          [euro, price, margin, date, shipment]);
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      await connection.query(
          'insert into prices (euro, price, margin, date, shipmentDate) values (?,?,?,?,?)',
          [euro, price, margin, date, shipment]);
    }
  }

  static readFromPricesTable(String shipmentDate) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    var tableAlreadyExists = await MySql.tableExists(connection, 'prices');
    if (tableAlreadyExists == false) {
      return;
    }
    if (tableAlreadyExists) {
      var results;
      try {
        results = await connection.query(
            "SELECT euro, price, margin FROM prices WHERE shipmentDate='$shipmentDate' ORDER BY id DESC LIMIT 1");
      } catch (Exception) {
        MySql.dBconnection();
        connection = await WelcomeScreen.connection;
        print('czytam z tabeli prices');
        if (connection == null) {
          return;
        }
        results = await connection.query(
            "SELECT euro, price, margin FROM prices WHERE shipmentDate='$shipmentDate' ORDER BY id DESC LIMIT 1");
      }
      return results;
    } else {
      return;
    }
  }
}
