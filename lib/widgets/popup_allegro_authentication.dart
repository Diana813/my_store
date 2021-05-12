import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_post/allegro_api/authentication.dart';
import 'package:my_store/utlis/colors.dart';

class PopUpAllegroAuth extends StatelessWidget {
  final BuildContext contextValue;
  static var _response;

  static get response => _response;

  PopUpAllegroAuth({
    @required this.contextValue,
  });

  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: Text('Aplikacja nie ma dostępu do zasobów Allegro'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
              'Połącz aplikację ze swoim kontem Allegro i spróbuj jeszcze raz'),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () async {
            _response = await AuthenticateClient.createClient();
            Navigator.of(context).pop();
          },
          child: Text(
            'Rozpocznij autoryzację',
            style: TextStyle(color: Color(ColorsMyStore.PrimaryColor)),
          ),
        ),
        new TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Anuluj',
                style: TextStyle(color: Color(ColorsMyStore.PrimaryColor))),
          ),
        ),
      ],
    );
  }
}
