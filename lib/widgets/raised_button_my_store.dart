import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utils/colors.dart';

class RaisedButtonMyStore extends StatelessWidget {
  final Function onClick;
  final Widget childWidget;
  final double paddingVertical;
  final double paddingHorizontal;
  final Color color;

  RaisedButtonMyStore(
      {@required this.onClick,
      @required this.childWidget,
      @required this.paddingHorizontal,
      @required this.paddingVertical,
      @required this.color});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.symmetric(
              vertical: paddingVertical, horizontal: paddingHorizontal)),
          backgroundColor: MaterialStateProperty.all(color),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
          ))),
      onPressed: onClick,
      child: childWidget,
    );
  }
}
