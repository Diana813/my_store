import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utlis/colors.dart';

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
    return GridView.count(
      shrinkWrap: true,
      crossAxisCount: 10,
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: launchURLAmazon,
            child: Image.asset('assets/images/amazon_logo.png'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(
                    ColorsMyStore.AccentColor), // Use the component's default.
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: launchURLCeneo,
            child: Image.asset('assets/images/ceneo_logo.png'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(
                    ColorsMyStore.AccentColor), // Use the component's default.
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: launchURLGoogle,
            child: Image.asset('assets/images/google_logo.png'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(
                    ColorsMyStore.AccentColor), // Use the component's default.
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: launchURLAllegro,
            child: Image.asset('assets/images/allegro_logo.png'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(
                    ColorsMyStore.AccentColor), // Use the component's default.
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: ElevatedButton(
            onPressed: launchURLYouTube,
            child: Image.asset('assets/images/you_tube.png'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(
                Color(
                    ColorsMyStore.AccentColor), // Use the component's default.
              ),
            ),
          ),
        ),
      ],
    );
  }
}
