import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppWindow extends StatelessWidget {
  final Widget myScreen;
  final Widget windowButtons;

  AppWindow(@required this.myScreen, this.windowButtons);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white],
            stops: [0.0, 1.0]),
      ),
      child: Column(
        children: [
          Container(
            color: Colors.white,
            child: WindowTitleBarBox(
              child: Row(
                children: [
                  Expanded(
                    child: MoveWindow(),
                  ),
                  windowButtons,
                ],
              ),
            ),
          ),
          Expanded(child: myScreen)
        ],
      ),
    );
  }
}
