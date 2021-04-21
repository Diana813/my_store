import 'dart:async';

import 'package:mysql1/mysql1.dart';

class MySql {
  static const user = '';
  static const port = 3306;
  static const host = '';
  static const password = '';
  static const db = '';

  static Future<MySqlConnection> dBconnection() async {
    // Open a connection (testdb should already exist)
    return await MySqlConnection.connect(ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db));
  }

  static getTablesList(MySqlConnection connection) async {
    var tables = await connection.query(
        "SELECT * FROM information_schema.tables WHERE table_schema = '$db' AND table_name != 'prices' AND table_name NOT LIKE '%_ch%'");
    return tables;
  }

  static seekAndDestroy_query(MySqlConnection connection, String tableName) {
    /*var id = connection.query(
        "Select id from information_schema.processlist WHERE table_schema = '$db' AND table_name = '$tableName' order by id desc limit 1");
    connection.query('Kill $id');*/
    connection.query('Drop table $tableName');
  }

  static checkIfDataLoaded(MySqlConnection connection) async {
    var result =
        await connection.query("Select * from information_schema.processlist");
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
