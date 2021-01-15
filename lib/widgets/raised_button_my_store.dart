import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RaisedButtonMyStore extends StatelessWidget {
  final Function onClick;
  final Widget childWidget;
  final double paddingVertical;
  final double paddingHorizontal;

  RaisedButtonMyStore(
      {@required this.onClick,
      @required this.childWidget,
      @required this.paddingHorizontal,
      @required this.paddingVertical});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: new EdgeInsets.symmetric(
          vertical: paddingVertical, horizontal: paddingHorizontal),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      onPressed: onClick,
      child: childWidget,
    );
  }
}
