import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utils/colors.dart';

class PopUpDialog extends StatelessWidget {
  final String message;
  final String advice;
  final String textButton;
  final Function onPressedContinue;

  PopUpDialog(
      {@required this.message,
      this.advice,
      this.textButton,
      this.onPressedContinue});

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(message),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(advice == null ? '' : advice),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressedContinue,
          child: Text(
            textButton == null ? '' : textButton,
            style: TextStyle(color: Color(ColorsMyStore.PrimaryColor)),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text(
              'OK',
              style: TextStyle(color: Color(ColorsMyStore.PrimaryColor)),
            ),
          ),
        ),
      ],
    );
  }
}
