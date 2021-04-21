import 'package:mysql1/mysql1.dart';

import 'mySql.dart';

class PricesTable {
  static const db = MySql.db;

  static createTablePrices(MySqlConnection connection) async {
    //check if prices table exist
    var tablePrices = await connection.query(
        'SELECT * FROM information_schema.tables WHERE table_schema = "$db" AND table_name = "prices" LIMIT 1');
    print(tablePrices);
    if (tablePrices.toString() == "()") {
      await connection.query(
          'CREATE TABLE IF NOT EXISTS prices (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, euro DOUBLE,  price DOUBLE, margin DOUBLE, date DATE, shipmentDate TEXT)');
    }
  }

  static insertDataToPrices(MySqlConnection connection, String euro,
      String price, String margin, String date, String shipment) async {
    var result = await connection.query(
        'insert into prices (euro, price, margin, date, shipmentDate) values (?,?,?,?,?)',
        [euro, price, margin, date, shipment]);
    print('Inserted row id=${result.insertId}');
  }

  static readFromPricesTable(String shipmentDate,
      MySqlConnection connection) async {
    var results = await connection.query(
        "SELECT euro, price, margin FROM prices WHERE shipmentDate='$shipmentDate' ORDER BY id DESC LIMIT 1");
    return results;
  }
}
