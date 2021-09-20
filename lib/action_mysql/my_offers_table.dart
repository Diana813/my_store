import 'package:my_store/screens/welcome_screen.dart';
import 'package:mysql1/mysql1.dart';

import 'mySql.dart';

class MyOffersTable {
  static const db = MySql.db;

  static createTableMyOffer() async {
    MySqlConnection connection = await WelcomeScreen.connection;
    try {
      await connection.query(
          'CREATE TABLE IF NOT EXISTS My_offers (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, EAN VARCHAR(100) NOT NULL UNIQUE KEY, name TEXT, description TEXT, price TEXT, image_urls TEXT, last_usage DATE)');
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      await connection.query(
          'CREATE TABLE IF NOT EXISTS My_offers (id int NOT NULL AUTO_INCREMENT PRIMARY KEY, EAN VARCHAR(100) NOT NULL UNIQUE KEY, name TEXT, description TEXT, price TEXT, image_urls TEXT, last_usage DATE)');
    }
  }

  static addEANToTableMyOffer(String EAN, String date) async {
    if (EAN == 'null') {
      return;
    }
    MySqlConnection connection = await WelcomeScreen.connection;
    try {
      await connection.query(
          "insert ignore into My_offers (EAN, name, description, price,image_urls, last_usage) values (?,?,?,?,?,?)",
          [EAN, '', '', '', '', date]);
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      await connection.query(
          "insert ignore into My_offers (EAN, name, description, price,image_urls, last_usage) values (?,?,?,?,?,?)",
          [EAN, '', '', '', '', date]);
    }
  }

  static addPhotoURLs(String urls, String EAN) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    try {
      await connection.query(
          "update My_offers set image_urls = '$urls' where EAN = '$EAN'");
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      await connection.query(
          "update My_offers set image_urls = '$urls' where EAN = '$EAN'");
    }
  }

  static updateDate(String EAN, String date) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    try {
      await connection.query(
          "update My_offers set last_usage = '$date' where EAN = '$EAN'");
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      await connection.query(
          "update My_offers set last_usage = '$date' where EAN = '$EAN'");
    }
  }

  static deletePhotoURLs(String EAN) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    try {
      await connection
          .query("update My_offers set image_urls = '' where EAN = '$EAN'");
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return;
      }
      await connection
          .query("update My_offers set image_urls = '' where EAN = '$EAN'");
    }
  }

  static getPhotosURLs(String EAN) async {
    MySqlConnection connection = await WelcomeScreen.connection;
    try {
      return await connection
          .query("select image_urls from My_offers where EAN = '$EAN'");
    } catch (Exception) {
      MySql.dBconnection();
      connection = await WelcomeScreen.connection;
      if(connection == null){
        return '()';
      }
      return await connection
          .query("select image_urls from My_offers where EAN = '$EAN'");
    }
  }
}
