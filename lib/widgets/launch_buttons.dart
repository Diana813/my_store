import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LaunchUrl extends StatelessWidget {
  final Function launchURLAmazon;
  final Function launchURLCeneo;
  final Function launchURLGoogle;
  final Function launchURLAllegro;
  final Function launchURLYouTube;

  LaunchUrl(
      {@required this.launchURLAmazon,
      @required this.launchURLCeneo,
      @required this.launchURLGoogle,
      @required this.launchURLAllegro,
      @required this.launchURLYouTube});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 5,
        padding: const EdgeInsets.symmetric(horizontal:250),
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: launchURLAmazon,
              child: Image.asset('assets/images/amazon_logo.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: launchURLCeneo,
              child: Image.asset('assets/images/ceneo_logo.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: launchURLGoogle,
              child: Image.asset('assets/images/google_logo.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: launchURLAllegro,
              child: Image.asset('assets/images/allegro_logo.png'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: RaisedButton(
              onPressed: launchURLYouTube,
              child: Image.asset('assets/images/you_tube.png'),
            ),
          ),
        ],
      ),
    );
  }
}
