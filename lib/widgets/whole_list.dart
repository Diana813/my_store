import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/brain/network_search_brain.dart';
import 'package:my_store/brain/products_list_brain.dart';
import 'package:my_store/widgets/list_item.dart';

class WholeList extends StatelessWidget {
  final ScrollController controller;
  final List items;
  final String euroRate;
  final String newRetail;
  final String margin;
  final Widget at_the_auction_check_box;
  final Widget sold_check_box;

  WholeList(
      {@required this.controller,
      @required this.items,
      @required this.euroRate,
      @required this.newRetail,
      @required this.margin,
      @required this.at_the_auction_check_box,
      @required this.sold_check_box});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollbar.rrect(
      alwaysVisibleScrollThumb: true,
      controller: controller,
      labelTextBuilder: (offset) {
        final int currentItem = controller.hasClients
            ? (controller.offset /
                    controller.position.maxScrollExtent *
                    items.length)
                .floor()
            : 0;

        return Text("$currentItem");
      },
      child: ListView.builder(
        controller: controller,
        itemCount: items.length,
        itemExtent: 250,
        itemBuilder: (context, index) {
          EasyLoading.dismiss();
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: ListItemMyStore(
              at_the_auction_check_box: at_the_auction_check_box,
              sold_check_box: sold_check_box,
              EAN: items.elementAt(index).EAN == null
                  ? ''
                  : items.elementAt(index).EAN,
              name: items.elementAt(index).name == null ? '': items.elementAt(index).name,
              totalRetail: items.elementAt(index).totalRetail == null ? '': items.elementAt(index).totalRetail,
              minRetail: ProductsListBrain.displayMinPrize(euroRate, newRetail,
                  margin, items.elementAt(index).totalRetail),
              LPN: items.elementAt(index).LPN == null ? '': items.elementAt(index).LPN,
              launchURLAmazon: () {
                EasyLoading.show();
                String ASIN = items.elementAt(index).ASIN;
                NetworkSearchBrain.checkResponseAmazon(
                    'https://amazon.com/dp/$ASIN',
                    'Tego produktu nie ma już w sprzedaży w sklepie Amazon',
                    'Poszukaj w Google',
                    context);
              },
              launchURLCeneo: () {
                String name = items.elementAt(index).name;
                String finalName =
                    NetworkSearchBrain.findCeneoString(name, index, items);

                NetworkSearchBrain.launchURL(
                    'https://ceneo.pl/;szukaj-$finalName');
              },
              launchURLGoogle: () {
                String name = items.elementAt(index).name;
                NetworkSearchBrain.launchURL(
                    'https://google.com/search?q=Ceneo Amazon $name');
              },
              launchURLAllegro: () {
                String name = items.elementAt(index).name;
                String finalName =
                    NetworkSearchBrain.findCeneoString(name, index, items);
                NetworkSearchBrain.launchURL(
                    'https://allegro.pl/listing?string=$finalName');
              },
            ),
          );
        },
      ),
    );
  }
}
