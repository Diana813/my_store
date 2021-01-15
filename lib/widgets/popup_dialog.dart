import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopUpDialog extends StatelessWidget {
  final BuildContext context;
  final String message;
  final String advice;
  final Widget flatButton;

  PopUpDialog(
      {@required this.context,
      @required this.message,
      @required this.advice,
      this.flatButton});

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
        flatButton,
        new FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          textColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text('OK'),
          ),
        ),
      ],
    );
  }
}
