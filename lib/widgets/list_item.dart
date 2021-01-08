import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemMyStore extends StatelessWidget {
  final String EAN;
  final String name;
  final String totalRetail;
  final String LPN;
  final Function launchURLAmazon;
  final Function launchURLCeneo;
  final Function launchURLGoogle;

  ListItemMyStore(
      {@required this.EAN,
      @required this.name,
      @required this.totalRetail,
      @required this.LPN,
      @required this.launchURLAmazon,
      @required this.launchURLCeneo,
      @required this.launchURLGoogle});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text("Wystawiono"),
                Checkbox(
                  checkColor: Colors.white,
                  value: true,
                  onChanged: (bool newValue) {},
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text("Sprzedano"),
                Checkbox(
                  checkColor: Colors.white,
                  value: true,
                  onChanged: (bool newValue) {},
                ),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(15),
            child: SelectableText(
              EAN,
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.all(15),
            child: SelectableText(
              name,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(15),
            child: SelectableText(
              totalRetail,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(15),
            child: SelectableText(
              LPN,
              toolbarOptions: ToolbarOptions(copy: true),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(15),
            child: RaisedButton(
              onPressed: launchURLAmazon,
              child: Container(
                height: 50,
                child: Image.asset('assets/images/amazon_logo.png'),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(15),
            child: RaisedButton(
              onPressed: launchURLCeneo,
              child: Container(
                height: 50,
                child: Image.asset('assets/images/ceneo_logo.png'),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(15),
            child: RaisedButton(
              onPressed: launchURLGoogle,
              child: Container(
                height: 50,
                child: Image.asset('assets/images/google_logo.png'),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
