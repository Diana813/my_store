import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:mysql1/mysql1.dart';

import 'mySql.dart';

class ItemsTable {
  static const db = MySql.db;

  static createTableItems(String tableName, MySqlConnection connection) async {
    // Create excel table
    await connection.query(
        'CREATE TABLE $tableName (id int NOT NULL AUTO_INCREMENT PRIMARY KEY,shipmentDate TEXT, ASIN TEXT, EAN TEXT, name TEXT, euro TEXT, LPN TEXT)');
  }

  static readItemsDataFromDBTable(
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

  static Future<bool> addItemsToDb(
      MySqlConnection connection, List<Product> items) async {
    String tableName;

    if (items.elementAt(0).shipmentDate.contains('/')) {
      tableName =
          items.elementAt(0).shipmentDate.substring(0, 10).replaceAll('/', '_');
    } else {
      tableName =
          items.elementAt(0).shipmentDate.substring(0, 10).replaceAll('-', '_');
    }

    //drop if excel table exist
    await connection.query("DROP TABLE IF EXISTS $tableName");

    await createTableItems(tableName, connection);

    var results = await connection.queryMulti(
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
}
