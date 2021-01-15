import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemMyStore extends StatelessWidget {
  final Widget at_the_auction_check_box;
  final Widget sold_check_box;
  final String EAN;
  final String name;
  final String totalRetail;
  final String minRetail;
  final String LPN;
  final Function launchURLAmazon;
  final Function launchURLCeneo;
  final Function launchURLGoogle;
  final Function launchURLAllegro;

  ListItemMyStore(
      {@required this.at_the_auction_check_box,
      @required this.sold_check_box,
      @required this.EAN,
      @required this.name,
      @required this.totalRetail,
      @required this.minRetail,
      @required this.LPN,
      @required this.launchURLAmazon,
      @required this.launchURLCeneo,
      @required this.launchURLGoogle,
      @required this.launchURLAllegro});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Wystawiono"), at_the_auction_check_box],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [Text("Sprzedano"), sold_check_box],
          ),
        ),
        Expanded(
          flex: 4,
          child: Container(
            margin: EdgeInsets.all(10),
            child: SelectableText(
              name,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: SelectableText(
              EAN,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            margin: EdgeInsets.all(10),
            child: SelectableText(
              LPN,
              toolbarOptions: ToolbarOptions(copy: true),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(10),
            child: SelectableText(
              totalRetail,
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Container(
            margin: EdgeInsets.all(10),
            child: SelectableText(
              minRetail,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: launchURLAmazon,
                  child: Image.asset('assets/images/amazon_logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: launchURLCeneo,
                  child: Image.asset('assets/images/ceneo_logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: launchURLGoogle,
                  child: Image.asset('assets/images/google_logo.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: RaisedButton(
                  onPressed: launchURLAllegro,
                  child: Image.asset('assets/images/allegro_logo.png'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
