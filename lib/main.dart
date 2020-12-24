import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/colors.dart';
import 'products_list_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Store',
      theme: new ThemeData(
        primarySwatch:
            MaterialColor(ColorsMyStore.PrimaryColor, ColorsMyStore.color),
      ),
      home: new MyHomePage(title: 'My Store'),
    );
  }
}
