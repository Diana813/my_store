import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/action_find_item_on_the_internet/network_search_brain.dart';
import 'package:my_store/action_open_file/brain/file_picker_brain.dart';
import 'package:my_store/action_post/models/offer.dart';
import 'package:my_store/widgets/app_window.dart' as app_window;
import 'package:my_store/widgets/item_details_list.dart';
import 'package:my_store/widgets/launch_buttons.dart';
import 'package:my_store/widgets/window_buttons.dart';

class AllegroForm extends StatefulWidget {
  AllegroForm({Key key, this.product}) : super(key: key);
  final product;
  var imagesFiles;
  var miniImageFiles;

  @override
  _AllegroFormState createState() => _AllegroFormState();
}

class _AllegroFormState extends State<AllegroForm> {
  List<OfferModel> items = [];
  String finalName;

  @override
  void initState() {
    getName();
    super.initState();
  }

  getName() {
    String name = widget.product.name;
    finalName = NetworkSearchBrain.findCeneoString(name);
  }

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Colors.black87,
      width: 1,
      child: app_window.AppWindow(
          new Scaffold(
            appBar: AppBar(),
            body: ListView(
              children: [
                Container(
                  child: LaunchUrl(
                    launchURLAmazon: () {
                      EasyLoading.show();
                      String ASIN = widget.product.ASIN;
                      NetworkSearchBrain.checkResponseAmazon(ASIN, context);
                    },
                    launchURLGoogle: () {
                      String name = widget.product.name;
                      NetworkSearchBrain.launchURL(
                          'https://google.com/search?q=$name');
                    },
                    launchURLCeneo: () {
                      NetworkSearchBrain.launchURL(
                          'https://ceneo.pl/;szukaj-$finalName');
                    },
                    launchURLAllegro: () {
                      NetworkSearchBrain.launchURL(
                          'https://allegro.pl/listing?string=$finalName');
                    },
                    launchURLYouTube: () {
                      NetworkSearchBrain.launchURL(
                          'https://www.youtube.com/results?search_query=$finalName');
                    },
                  ),
                ),
                Container(
                  child: ItemDetailsList(
                    onTap: () async {
                      widget.imagesFiles =
                          await FilePickerBrain.openImageFile(context);
                      setState(() {});
                    },
                    imageFiles: widget.imagesFiles,
                    name: finalName,
                    EAN: widget.product.EAN.toString().split('.')[0],
                    onTapMini: () async {
                      widget.miniImageFiles =
                          await FilePickerBrain.openImageFile(context);
                      setState(() {});
                    },
                    miniImageFiles: widget.miniImageFiles,
                  ),
                )
              ],
            ),
          ),
          WindowButtons()),
    );
  }
}
