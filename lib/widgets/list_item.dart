import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utlis/colors.dart';

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
  final Function selectAndCopyTextName;
  final Function selectAndCopyTextEAN;
  final Function selectAndCopyTextLPN;
  final Function selectAndCopyTextTotalRetail;
  final Function selectAndCopyTextMinRetail;
  String imageUrl;

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
      @required this.launchURLYouTube,
      @required this.selectAndCopyTextName,
      @required this.selectAndCopyTextEAN,
      @required this.selectAndCopyTextLPN,
      @required this.selectAndCopyTextTotalRetail,
      @required this.selectAndCopyTextMinRetail,
      @required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Center(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.fromLTRB(8, 8, 8, 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Wystawiono"),
                              Checkbox(
                                  value: at_the_auction_value,
                                  onChanged: at_the_auction_on_change)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text("Sprzedano"),
                              Checkbox(
                                  value: sold_value, onChanged: sold_on_change)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        height: 100,
                        width: 150,
                        fit: BoxFit.contain,
                        fadeInDuration: Duration(milliseconds: 200),
                        imageUrl: imageUrl == null ||
                                imageUrl == 'null' ||
                                imageUrl == ''
                            ? 'https://mmp24.pl/i/articles/247870_root_1_png_shutterstock_zakupyonline_ma-C5-82e.jpg'
                            : imageUrl,
                        errorWidget: (context, url, error) => Icon(Icons.error,
                            color: Color(ColorsMyStore.AccentColor), size: 30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.all(10),
              child: SelectableText(
                name,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              focusColor: Colors.white,
              hoverColor: Color(ColorsMyStore.HoverColor),
              onTap: selectAndCopyTextEAN,
              child: Text(
                EAN,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: InkWell(
              focusColor: Colors.white,
              onTap: selectAndCopyTextLPN,
              hoverColor: Color(ColorsMyStore.HoverColor),
              child: Text(
                LPN,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: selectAndCopyTextTotalRetail,
              focusColor: Colors.white,
              hoverColor: Color(ColorsMyStore.HoverColor),
              child: Text(
                totalRetail,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: selectAndCopyTextMinRetail,
              hoverColor: Color(ColorsMyStore.HoverColor),
              focusColor: Colors.white,
              child: Text(
                minRetail,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: launchURLAmazon,
                          child: Image.asset(
                            'assets/images/amazon_logo.png',
                            width: 100,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(ColorsMyStore
                                  .AccentColor), // Use the component's default.
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: launchURLCeneo,
                          child: Image.asset(
                            'assets/images/ceneo_logo.png',
                            width: 100,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(ColorsMyStore
                                  .AccentColor), // Use the component's default.
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: launchURLGoogle,
                          child: Image.asset(
                            'assets/images/google_logo.png',
                            width: 100,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(ColorsMyStore
                                  .AccentColor), // Use the component's default.
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: launchURLAllegro,
                          child: Image.asset(
                            'assets/images/allegro_logo.png',
                            width: 100,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(ColorsMyStore
                                  .AccentColor), // Use the component's default.
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: ElevatedButton(
                          onPressed: launchURLYouTube,
                          child: Image.asset(
                            'assets/images/you_tube.png',
                            width: 100,
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Color(ColorsMyStore
                                  .AccentColor), // Use the component's default.
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
