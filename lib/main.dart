import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/screens/welcome_screen.dart';
import 'package:my_store/utlis/colors.dart';



void main() {
  runApp(MyApp());
  configLoading();

}
void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..progressColor = MaterialColor(ColorsMyStore.AccentColor, ColorsMyStore.color)
    ..backgroundColor = Colors.white
    ..indicatorColor = MaterialColor(ColorsMyStore.AccentColor, ColorsMyStore.color)
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;

}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Store',
      theme: new ThemeData(
        primarySwatch:
        MaterialColor(ColorsMyStore.PrimaryColor, ColorsMyStore.color),
        accentColor:
        MaterialColor(ColorsMyStore.AccentColor, ColorsMyStore.color),
        buttonColor:
        MaterialColor(ColorsMyStore.AccentColor, ColorsMyStore.color),
        visualDensity: VisualDensity.adaptivePlatformDensity,

      ),
      home: new WelcomeScreen(),
      builder: EasyLoading.init(),
    );
  }
}
