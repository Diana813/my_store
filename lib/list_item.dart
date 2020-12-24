import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemMyStore extends StatelessWidget {
  final String EAN;
  final String name;
  final String totalRetail;
  final String LPN;

  ListItemMyStore({this.EAN, this.name, this.totalRetail, this.LPN});


  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Checkbox(
                value: true,
                onChanged: (bool newValue) {},
              ),
              Text("Wystawiono"),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: [
              Checkbox(
                value: true,
                onChanged: (bool newValue) {},
              ),
              Text("Sprzedano"),
            ],
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text(EAN),
          ),
        ),
        Expanded(
            flex: 4,
            child: Container(margin: EdgeInsets.all(15), child: Text(name))),
        Expanded(
            flex: 2,
            child: Container(
                margin: EdgeInsets.all(15), child: Text(totalRetail))),
        Expanded(
            flex: 3,
            child: Container(margin: EdgeInsets.all(15), child: Text(LPN))),
      ],
    );
  }
}
