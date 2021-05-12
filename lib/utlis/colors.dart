import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

class ColorsMyStore {
  static const PrimaryColor =0xFF89ACBE/*0xFF849FBC*/ /*0xFF7E6A75*/;
  static const AccentColor = 0xFF88D5E4;
  static const HoverColor = 0xFF6088D5E4;
  static Map<int, Color> color =
  {
     50:Color.fromRGBO(42,210,160, .1),
    100:Color.fromRGBO(42,210,160, .2),
    200:Color.fromRGBO(42,210,160, .3),
    300:Color.fromRGBO(42,210,160, .4),
    400:Color.fromRGBO(42,210,160, .5),
    500:Color.fromRGBO(42,210,160, .6),
    600:Color.fromRGBO(42,210,160, .7),
    700:Color.fromRGBO(42,210,160, .8),
    800:Color.fromRGBO(42,210,160, .9),
    900:Color.fromRGBO(42,210,160, 1),
  };

  static var buttonColors = WindowButtonColors(
      iconNormal: Color(0xFF89ACBE),
      mouseOver: Color(0xFF88D5E4),
      mouseDown: Color(0xFF89ACBE),
      iconMouseOver: Color(0xFF89ACBE),
      iconMouseDown: Color(0xFF88D5E4));

  static var closeButtonColors = WindowButtonColors(
      mouseOver: Colors.red[700],
      mouseDown: Colors.red[900],
      iconNormal: Color(0xFF89ACBE),
      iconMouseOver: Colors.white);

}
