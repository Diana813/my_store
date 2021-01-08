import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListHeaderMyStore extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Visibility(
            visible: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text("Wystawiono"),
                  Checkbox(
                    value: true,
                    onChanged: (bool newValue) {},
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Visibility(
            visible: false,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text("Sprzedano"),
                  Checkbox(
                    value: true,
                    onChanged: (bool newValue) {},
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "EAN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "Nazwa",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "Cena",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "LPN",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "Amazon",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "Ceneo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(15),
            child: Text(
              "Google",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
