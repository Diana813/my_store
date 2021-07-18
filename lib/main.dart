import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/screens/welcome_screen.dart';
import 'package:my_store/utils/colors.dart';
import 'package:my_store/utils/navigation.dart';
import 'package:my_store/widgets/app_window.dart' as app_window;
import 'package:my_store/widgets/window_buttons.dart';

void main() {
  runApp(MyApp());
  configLoading();
  doWhenWindowReady(() {
    var initialSize = Size(1050, 720);
    appWindow.minSize = initialSize;
    appWindow.size = initialSize;
    appWindow.alignment = Alignment.center;
    appWindow.title = 'My Store';
    appWindow.show();
  });
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 3000)
    ..indicatorType = EasyLoadingIndicatorType.ring
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..maskType = EasyLoadingMaskType.black
    ..progressColor =
        MaterialColor(ColorsMyStore.AccentColor, ColorsMyStore.color)
    ..backgroundColor = Colors.white
    ..indicatorColor =
        MaterialColor(ColorsMyStore.AccentColor, ColorsMyStore.color)
    ..textColor = Colors.black
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class MyApp extends StatelessWidget {
  MyApp({Key key, this.tableName}) : super(key: key);
  String tableName;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: Scaffold(
        body: WindowBorder(
          color: Colors.black87,
          width: 1,
          child: app_window.AppWindow(
            WelcomeScreen(
              tableName: tableName,
            ),
            WindowButtons(
              closeButtonOnPressed: () async {
                await NavigationMyStore.closeApp();
              },
            ),
          ),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }
}
