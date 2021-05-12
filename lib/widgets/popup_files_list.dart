import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utlis/colors.dart';

class PopUpDialogList extends StatelessWidget {
  final BuildContext context;
  final String message;
  final List<String> filesList;
  final bool listIsNotEmpty;
  final Widget listWidget;

  PopUpDialogList(
      {@required this.context,
      @required this.message,
      this.filesList,
      @required this.listIsNotEmpty,
      @required this.listWidget});

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text(message),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          listIsNotEmpty
              ? Container(
                  child: listWidget,
                  width: 200,
                  height: 200,
                )
              : ListTile(
                  leading: Image.asset('assets/images/empty_list.png'),
                  title: Text('Brak plików do wyświetlenia.'),
                )
        ],
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('OK', style: TextStyle(color: Color(ColorsMyStore.PrimaryColor))),
            ),
          ),
        ),
      ],
    );
  }
}
