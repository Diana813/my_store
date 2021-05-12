import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/main.dart';
import 'package:my_store/screens/allegro_form_screen.dart';
import 'package:my_store/screens/welcome_screen.dart';
import 'package:mysql1/mysql1.dart';

class NavigationMyStore {
  static navigationBackToWelcomeScreen(BuildContext context, String tableName) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => new MyApp(
                  tableName: tableName,
                )));
  }

  static closeApp() async {
    MySqlConnection conn = await WelcomeScreen.connection;
    await conn.close();
    appWindow.close();
  }

  static navigationForwardToAllegroScreen(
      List<Product> items, BuildContext context, int index) async {
    bool result = await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => new AllegroForm(
                product: items.elementAt(index),
              )),
    );
    return result;
  }
}
