import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utlis/colors.dart';

class ListHeaderMyStore extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 30, 20, 0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color:
                MaterialColor(ColorsMyStore.PrimaryColor, ColorsMyStore.color),
            width: 1.0,
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Visibility(
              visible: false,
              child: Padding(
                padding: const EdgeInsets.all(10),
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
                padding: const EdgeInsets.all(10),
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
            flex: 4,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Nazwa",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "EAN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "LPN",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Cena (€)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Cena (zł)",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(10),
              child: Text(
                "Szukaj",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
