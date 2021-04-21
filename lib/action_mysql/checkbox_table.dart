import 'package:mysql1/mysql1.dart';

import 'mySql.dart';

class CheckBoxTable {
  static const db = MySql.db;

  static createTableCheckBox(
      String tableName, MySqlConnection connection) async {
    if (connection == null) {
      connection = await MySql.dBconnection();
    }
    var tableCheckBox;
    /*try {*/
    /* tableCheckBox = await connection.query(
          'SELECT * FROM information_schema.tables WHERE table_schema = "$db" AND table_name = "$tableName" LIMIT 1');
      if (tableCheckBox == '()') {*/
    tableCheckBox = await connection.query(
        'CREATE TABLE IF NOT EXISTS $tableName (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, LPN TEXT, atAuction bool, sold bool)');

    /* } catch (Exception) {
      print("tabela jeszcze nie istnieje");
    }*/

    return tableCheckBox;
  }

  static insertDataToCheckBoxesAtAuction(
      MySqlConnection connection, tableName, String LPN, bool atAuction) async {
    if (connection == null) {
      connection = await MySql.dBconnection();
    }
    await createTableCheckBox(tableName, connection);
    var result = await connection.query(
        "SELECT atAuction FROM $tableName WHERE LPN = '$LPN' ORDER BY id DESC LIMIT 1");
    if (result == '()') {
      result = await connection.query(
          "insert into $tableName (LPN, atAuction) values (?,?)",
          [LPN, atAuction]);
      print('Inserted row id=${result.insertId}');
    } else {
      result = await connection.query(
          "update $tableName set atAuction = '$atAuction' where LPN = '$LPN'");
      print('Updated row id=${result.insertId}');
    }
  }

  static insertDataToCheckBoxesSold(
      MySqlConnection connection, tableName, String LPN, bool sold) async {
    if (connection == null) {
      connection = await MySql.dBconnection();
    }
    await createTableCheckBox(tableName, connection);

    var result = await connection.query(
        "SELECT sold FROM $tableName WHERE LPN= $LPN ORDER BY id DESC LIMIT 1");

    if (result == "()") {
      result = await connection.query(
          'insert into $tableName (LPN, sold) values (?,?)', [LPN, sold]);
      print('Inserted row id=${result.insertId}');
    } else {
      result = await connection
          .query("update $tableName set sold = $sold where LPN = $LPN");
      print('Updated row id=${result.insertId}');
    }
  }

  static readFromCheckBoxes(
      tableName, String LPN, MySqlConnection connection) async {
    if (connection == null) {
      connection = await MySql.dBconnection();
    }
    await createTableCheckBox(tableName, connection);
    var result = await connection.query(
        "SELECT atAuction, sold FROM $tableName WHERE LPN ='$LPN' ORDER BY id DESC LIMIT 1");
    return result;
  }
}
