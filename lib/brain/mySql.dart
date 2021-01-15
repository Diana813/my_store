import 'dart:async';

import 'package:my_store/models/product_model.dart';
import 'package:mysql1/mysql1.dart';

class MySql {
  static const user = 'user';
  static const port = 3306;
  static const host = 'hostr';
  static const password = 'password';
  static const db = 'db';

  static createTablePrices(MySqlConnection connection) async {
    //check if prices table exist
    var tablePrices = await connection.query(
        'SELECT * FROM information_schema.tables WHERE table_schema = "$db" AND table_name = "prices" LIMIT 1');
    print(tablePrices);
    if (tablePrices.toString() == "()") {
      // Create prices table
      await connection.query(
          'CREATE TABLE prices (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, euro DOUBLE,  price DOUBLE, margin DOUBLE, date DATE, shipmentDate TEXT)');
    }
  }

  static createTableExcel(String tableName, MySqlConnection connection) async {
    // Create excel table
    await connection.query(
        'CREATE TABLE $tableName (id int NOT NULL AUTO_INCREMENT PRIMARY KEY,shipmentDate TEXT, ASIN TEXT, EAN TEXT, name TEXT, euro TEXT, LPN TEXT)');
  }

  static createTableCheckBox(
      String tableName, MySqlConnection connection) async {
    //check if prices table exist
    var tableCheckBox = await connection.query(
        'SELECT * FROM information_schema.tables WHERE table_schema = "$db" AND table_name = "$tableName" LIMIT 1');
    print(tableCheckBox);
    if (tableCheckBox.toString() == "()") {
      // Create excel table
      await connection.query(
          'CREATE TABLE $tableName (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, LPN TEXT, atAuction bool, sold bool)');
    }
  }

  static insertDataToCheckBoxesAtAuction(MySqlConnection connection,
      List<Product> items, String LPN, bool atAuction) async {
    String tableName =
        items.elementAt(0).shipmentDate.substring(0, 10).replaceAll('-', '_') +
            '_ch';
    MySql.createTableCheckBox(tableName, connection);

    var result = await connection.query(
        'insert into $tableName (LPN, atAuction) values (?,?)',
        [LPN, atAuction]);
    print('Inserted row id=${result.insertId}');
    // Finally, close the connection
  }

  static insertDataToCheckBoxesSold(MySqlConnection connection,
      List<Product> items, String LPN, bool sold) async {
    String tableName =
        items.elementAt(0).shipmentDate.substring(0, 10).replaceAll('-', '_') +
            '_ch';
    MySql.createTableCheckBox(tableName, connection);

    var result = await connection
        .query('insert into $tableName (LPN, sold) values (?,?)', [LPN, sold]);
    print('Inserted row id=${result.insertId}');
// Finally, close the connection
  }

  static readFromCheckBoxes(
      String shipmentDate, String LPN, MySqlConnection connection) async {
    String tableName =
        shipmentDate.substring(0, 10).replaceAll('-', '_') + '_ch';
    // Query the database using a parameterized query
    var results = await connection.query(
        "SELECT atAuction, sold FROM $tableName WHERE LPN ='$LPN' ORDER BY id DESC LIMIT 1");
    return results;
  }

  static Future<MySqlConnection> dBconnection() async {
    // Open a connection (testdb should already exist)
    return await MySqlConnection.connect(ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db));
  }

  static insertDataToPrices(MySqlConnection connection, String euro,
      String price, String margin, String date, String shipment) async {
    // Insert some data
    var result = await connection.query(
        'insert into prices (euro, price, margin, date, shipmentDate) values (?,?,?,?,?)',
        [euro, price, margin, date, shipment]);
    print('Inserted row id=${result.insertId}');
    // Finally, close the connection
  }

  static readFromPricesTable(
      String shipmentDate, MySqlConnection connection) async {
    // Query the database using a parameterized query
    var results = await connection.query(
        "SELECT euro, price, margin FROM prices WHERE shipmentDate='$shipmentDate' ORDER BY id DESC LIMIT 1");
    return results;
  }

  /*static Future<int> insertDataToExcelTable(
      MySqlConnection connection,
      String tableName,
      String shipmentDate,
      String ASIN,
      String EAN,
      String name,
      String euro,
      String LPN) async {
    // Insert excel data
    var result = await connection.query(
        'insert into $tableName (shipmentDate, ASIN, EAN, name, euro, LPN) values (?,?,?,?,?,?)',
        [shipmentDate, ASIN, EAN, name, euro, LPN]);
    return result.insertId;
  }*/

  /*static readFromTableExcel(
      String shipmentDate, MySqlConnection connection) async {
    // Query the database using a parameterized query
    var results = await connection.query(
        "SELECT EAN, name, euro, LPN WHERE shipmentDate='$shipmentDate'");
    return results;
  }*/

  /*static Future<bool> checkIfAllExcelDataAreLoadedToDB(
      String tableName, MySqlConnection connection, List items) async {
    //check if excel table exist
    var alreadyExist = await connection.query(
        "SELECT * FROM information_schema.tables WHERE table_schema = '$db' AND table_name = '$tableName' LIMIT 1");

    if (alreadyExist.toString() != "()") {
      String numberOfItemsInDb;
      var result = await connection
          .query("SELECT id FROM $tableName ORDER BY id DESC LIMIT 1");
      for (var row in result) {
        numberOfItemsInDb = row[0].toString();
      }
      numberOfItemsInDb = numberOfItemsInDb.replaceAll('[', '');
      numberOfItemsInDb = numberOfItemsInDb.replaceAll(']', '');
      print(numberOfItemsInDb);
      print(items.length.toString());
      if (numberOfItemsInDb == (items.length).toString()) {
        print("Załadował wszystko");
        return true;
      } else {
        print('Jeszcze nie załadował wszystkiego');
        return false;
      }
    } else {
      print('Tabela nie istnieje');
      return true;
    }
  }
*/
  static getTablesList(MySqlConnection connection) async {
    var tables = await connection.query(
        "SELECT * FROM information_schema.tables WHERE table_schema = '$db' AND table_name != 'prices' AND table_name NOT LIKE '%_ch%'");
    return tables;
  }

  static readExcelDataFromDBTable(
      MySqlConnection connection, String tableName) async {
    List<Product> dbData = [];
    var result = await connection.query("SELECT * FROM $tableName");
    for (var row in result) {
      final product = Product(
        shipmentDate: row[1].toString(),
        ASIN: row[2].toString(),
        EAN: row[3].toString(),
        name: row[4].toString(),
        totalRetail: row[5].toString(),
        LPN: row[6].toString(),
      );
      dbData.add(product);
    }
    return dbData;
  }

  /*static addFileToDb(
      List<Product> excelData, MySqlConnection connection) async {
    String tableName = excelData
        .elementAt(0)
        .shipmentDate
        .substring(0, 10)
        .replaceAll('-', '_');

    //drop if excel table exist
    await connection.query("DROP TABLE IF EXISTS $tableName");

    await MySql.createTableExcel(tableName, connection);

    for (Product product in excelData) {
      MySql.insertDataToExcelTable(
          connection,
          tableName,
          product.at_the_auction,
          product.sold,
          product.shipmentDate,
          product.ASIN,
          product.EAN,
          product.name,
          product.totalRetail,
          product.LPN);
    }
  }*/

  static Future<bool> addExcelToDb(
      MySqlConnection connection, List<Product> items) async {
    String tableName =
        items.elementAt(0).shipmentDate.substring(0, 10).replaceAll('-', '_');

    //drop if excel table exist
    await connection.query("DROP TABLE IF EXISTS $tableName");

    await MySql.createTableExcel(tableName, connection);

    await connection.queryMulti(
        'insert into $tableName (shipmentDate, ASIN, EAN, name, euro, LPN) values (?,?,?,?,?,?)',
        [
          for (int i = 0; i < items.length; i++)
            [
              items.elementAt(i).shipmentDate,
              items.elementAt(i).ASIN,
              items.elementAt(i).EAN,
              items.elementAt(i).name,
              items.elementAt(i).totalRetail,
              items.elementAt(i).LPN
            ]
        ]);
    return true;
  }

  static seekAndDestroy_query(MySqlConnection connection, String tableName) {
    /*var id = connection.query(
        "Select id from information_schema.processlist WHERE table_schema = '$db' AND table_name = '$tableName' order by id desc limit 1");
    connection.query('Kill $id');*/
    connection.query('Drop table $tableName');
  }

  static checkIfDataLoaded(MySqlConnection connection) async {
    var result = await connection.query(
        "Select * from information_schema.processlist");
    if (result != null && result.toString() != "()") {
      print('Result nie jest null');
      print(result.toString());
      return false;
    } else {
      print('Result jest null');
      print(result.toString());
      return true;
    }
  }
}
