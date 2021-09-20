import 'dart:async';

import 'package:my_store/screens/welcome_screen.dart';
import 'package:mysql1/mysql1.dart';

class MySql {
  static const user = '';
  static const port = 0;
  static const host = '';
  static const password = '';
  static const db = '';

  static Future<MySqlConnection> dBconnection() async {
    print('łączę');
    WelcomeScreen.connection = MySqlConnection.connect(ConnectionSettings(
        host: host, port: port, user: user, password: password, db: db));
  }

  static getTablesList() async {
    MySqlConnection connection = await WelcomeScreen.connection;
    var list;
    try {
      list = await connection.query(
          "SELECT * FROM information_schema.tables WHERE table_schema = '$db' AND table_name != 'prices' AND table_name != 'My_offers' AND table_name NOT LIKE '%_ch%'");
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if (connection == null) {
        return;
      }
      print('odczytuję dane o tytułach tabel');
      list = await connection.query(
          "SELECT * FROM information_schema.tables WHERE table_schema = '$db' AND table_name != 'prices' AND table_name != 'My_offers' AND table_name NOT LIKE '%_ch%'");
    }
    return list;
  }

  static Future<bool> tableExists(
      MySqlConnection connection, String tableName) async {
    var table;
    try {
      table = await connection.query(
          'SELECT * FROM information_schema.tables WHERE table_schema = "$db" AND table_name = "$tableName" LIMIT 1');
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if (connection == null) {
        return false;
      }
      print('czy tabela istnieje');
      table = await connection.query(
          'SELECT * FROM information_schema.tables WHERE table_schema = "$db" AND table_name = "$tableName" LIMIT 1');
    }

    if (table.toString() == '()') {
      return false;
    } else {
      return true;
    }
  }

  static addColumn(String tableName, String columnName) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    await connection.query("ALTER TABLE $tableName ADD $columnName TEXT");
  }

  static deleteTable(String tableName) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    try {
      await connection.query("DROP TABLE IF EXISTS $tableName");
    } catch (e) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if (connection == null) {
        return;
      }
      await connection.query("DROP TABLE IF EXISTS $tableName");
    }
  }
}
