import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpDialog extends StatelessWidget {
  final BuildContext context;
  final String message;
  final String advice;

  PopUpDialog(
      {@required this.context, @required this.message, @required this.advice});

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(message),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(advice),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
