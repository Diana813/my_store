import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListItemMyStore extends StatelessWidget {
  final bool at_the_auction_value;
  final bool sold_value;
  final Function at_the_auction_on_change;
  final Function sold_on_change;
  final String EAN;
  final String name;
  final String totalRetail;
  final String minRetail;
  final String LPN;
  final Function onTap;
  final Function launchURLAmazon;
  final Function launchURLCeneo;
  final Function launchURLGoogle;
  final Function launchURLAllegro;
  final Function launchURLYouTube;

  ListItemMyStore(
      {@required this.at_the_auction_value,
      @required this.sold_value,
      @required this.at_the_auction_on_change,
      @required this.sold_on_change,
      @required this.EAN,
      @required this.name,
      @required this.totalRetail,
      @required this.minRetail,
      @required this.LPN,
      @required this.onTap,
      @required this.launchURLAmazon,
      @required this.launchURLCeneo,
      @required this.launchURLGoogle,
      @required this.launchURLAllegro,
      @required this.launchURLYouTube});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child:
        Row(
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Wystawiono"),
              Checkbox(
                  value: at_the_auction_value, onChanged: at_the_auction_on_change)
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Sprzedano"),
              Checkbox(value: sold_value, onChanged: sold_on_change)
            ],
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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: false,
              childAspectRatio: MediaQuery.of(context).size.width /
                  MediaQuery.of(context).size.height,
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RaisedButton(
                    onPressed: launchURLAmazon,
                    child: Image.asset('assets/images/amazon_logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RaisedButton(
                    onPressed: launchURLCeneo,
                    child: Image.asset('assets/images/ceneo_logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RaisedButton(
                    onPressed: launchURLGoogle,
                    child: Image.asset('assets/images/google_logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RaisedButton(
                    onPressed: launchURLAllegro,
                    child: Image.asset('assets/images/allegro_logo.png'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: RaisedButton(
                    onPressed: launchURLYouTube,
                    child: Image.asset('assets/images/you_tube.png'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
       ),
    );
  }
}
