import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:my_store/utlis/colors.dart';

class WindowButtons extends StatelessWidget {
  final Function closeButtonOnPressed;

  WindowButtons({this.closeButtonOnPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        MinimizeWindowButton(colors: ColorsMyStore.buttonColors),
        MaximizeWindowButton(colors: ColorsMyStore.buttonColors),
        CloseWindowButton(
          colors: ColorsMyStore.closeButtonColors,
          onPressed: closeButtonOnPressed,
        ),
      ],
    );
  }
}
