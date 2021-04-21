import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/action_display_list_of_items/brain/products_list_brain.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/action_find_item_on_the_internet/network_search_brain.dart';
import 'package:my_store/action_mysql/checkbox_table.dart';
import 'package:my_store/widgets/list_item.dart';
import 'package:mysql1/mysql1.dart';

class WholeList extends StatefulWidget {
  final ScrollController controller;
  final List<Product> items;
  final String euroRate;
  final String newRetail;
  final String margin;
  final MySqlConnection connection;
  final String checkboxesTableName;

  WholeList(
      {@required this.controller,
      @required this.items,
      @required this.euroRate,
      @required this.newRetail,
      @required this.margin,
      @required this.connection,
      @required this.checkboxesTableName});

  @override
  _WholeListState createState() => _WholeListState();
}

class _WholeListState extends State<WholeList> {
  bool auctionChange = false;

  bool soldChange = false;

  @override
  Widget build(context) {
    return DraggableScrollbar.rrect(
      alwaysVisibleScrollThumb: true,
      controller: widget.controller,
      labelTextBuilder: (offset) {
        final int currentItem = widget.controller.hasClients
            ? (widget.controller.offset /
                    widget.controller.position.maxScrollExtent *
                    widget.items.length)
                .floor()
            : 0;

        return Text("$currentItem");
      },
      child: ListView.builder(
        physics: ClampingScrollPhysics(),
        controller: widget.controller,
        itemCount: widget.items.length,
        itemExtent: 250,
        itemBuilder: (contex, index) {
          EasyLoading.dismiss();
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: ListItemMyStore(
              EAN: widget.items.elementAt(index).EAN == null
                  ? ''
                  : widget.items.elementAt(index).EAN,
              name: widget.items.elementAt(index).name == null
                  ? ''
                  : widget.items.elementAt(index).name,
              totalRetail: widget.items.elementAt(index).totalRetail == null
                  ? ''
                  : widget.items.elementAt(index).totalRetail,
              minRetail: ProductsListBrain.displayMinPrize(
                  widget.euroRate,
                  widget.newRetail,
                  widget.margin,
                  widget.items.elementAt(index).totalRetail),
              LPN: widget.items.elementAt(index).LPN == null
                  ? ''
                  : widget.items.elementAt(index).LPN,
              onTap: () async {
                await ProductsListBrain.goToAllegroScreen(
                    widget.items, context, index);
              },
              launchURLAmazon: () {
                EasyLoading.show();
                String ASIN = widget.items.elementAt(index).ASIN;
                NetworkSearchBrain.checkResponseAmazon(ASIN, context);
              },
              launchURLCeneo: () {
                String name = widget.items.elementAt(index).name;
                String finalName = NetworkSearchBrain.findCeneoString(name);

                NetworkSearchBrain.launchURL(
                    'https://ceneo.pl/;szukaj-$finalName');
              },
              launchURLGoogle: () {
                String name = widget.items.elementAt(index).name;
                NetworkSearchBrain.launchURL(
                    'https://google.com/search?q=Ceneo Amazon $name');
              },
              launchURLAllegro: () {
                String name = widget.items.elementAt(index).name;
                String finalName = NetworkSearchBrain.findCeneoString(name);
                NetworkSearchBrain.launchURL(
                    'https://allegro.pl/listing?string=$finalName');
              },
              launchURLYouTube: () {
                String name = widget.items.elementAt(index).name;
                print(name);
                String finalName = NetworkSearchBrain.findCeneoString(name);
                NetworkSearchBrain.launchURL(
                    'https://www.youtube.com/results?search_query=$finalName');
              },
              sold_on_change: (value) {
                setState(() {
                  widget.items.elementAt(index).sold = value;
                });
                CheckBoxTable.insertDataToCheckBoxesSold(
                    widget.connection,
                    widget.checkboxesTableName,
                    widget.items.elementAt(index).LPN,
                    value);
              },
              sold_value: widget.items.elementAt(index).sold,
              at_the_auction_value:
                  widget.items.elementAt(index).at_the_auction,
              at_the_auction_on_change: (value) async {
                setState(() {
                  widget.items.elementAt(index).at_the_auction = value;
                });
                CheckBoxTable.insertDataToCheckBoxesAtAuction(
                    widget.connection,
                    widget.checkboxesTableName,
                    widget.items.elementAt(index).LPN,
                    value);
              },
            ),
          );
        },
      ),
    );
  }
}
