import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/models/product_model.dart';
import 'package:my_store/widgets/list_header.dart';
import 'package:my_store/widgets/list_item.dart';

import '../brain/network_search_brain.dart';
import '../utlis/colors.dart';

class Products_Page extends StatefulWidget {
  Products_Page({Key key, this.productsList}) : super(key: key);
  final productsList;

  @override
  _Products_PageState createState() => new _Products_PageState();
}

class _Products_PageState extends State<Products_Page> {
  TextEditingController editingController = TextEditingController();
  String filePath = '';
  var bytes = null;
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("AppBar Title");
  var items = <Product>[];

  @override
  void initState() {
    items.addAll(widget.productsList);
    super.initState();
  }

  void _filterSearchResults(String query, List<Product> productsList) {
    List<Product> searchedProducts = <Product>[];
    searchedProducts.addAll(productsList);
    if (query.isNotEmpty) {
      List<Product> searchedProductsData = <Product>[];
      searchedProducts.forEach((item) {
        if ((item.EAN != null &&
                item.EAN.toLowerCase().contains(query.toLowerCase())) ||
            (item.name != null &&
                item.name.toLowerCase().contains(query.toLowerCase())) ||
            (item.totalRetail != null &&
                item.totalRetail.toLowerCase().contains(query.toLowerCase())) ||
            (item.LPN != null &&
                item.LPN.toLowerCase().contains(query.toLowerCase()))) {
          searchedProductsData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(searchedProductsData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(productsList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text('My Store'),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              TextField(
                onChanged: (value) {
                  _filterSearchResults(value, widget.productsList);
                },
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Wyszukaj",
                    hintText: "Wyszukaj",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: MaterialColor(
                          ColorsMyStore.PrimaryColor, ColorsMyStore.color),
                      width: 1.0,
                    ),
                  ),
                ),
                child: ListHeaderMyStore(),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    EasyLoading.dismiss();
                    return ListItemMyStore(
                      EAN: items.elementAt(index).EAN,
                      name: items.elementAt(index).name,
                      totalRetail: items.elementAt(index).totalRetail,
                      LPN: items.elementAt(index).LPN,
                      launchURLAmazon: () {
                        EasyLoading.show();
                        /*_progress=0;
                        EasyLoading.showProgress(_progress,
                            status: '${(_progress * 100).toStringAsFixed(0)}%');
                        _progress += 0.03;*/
                        String ASIN = items.elementAt(index).ASIN;
                        NetworkSearchBrain.checkResponseAmazon(
                            'https://amazon.com/dp/$ASIN',
                            'Tego produktu nie ma już w sprzedaży w sklepie Amazon',
                            'Poszukaj w Google',
                            context);
                      },
                      launchURLCeneo: () {
                        String name = items.elementAt(index).name;
                        List<String> finalName =
                            NetworkSearchBrain.findCeneoString(
                                name, index, items);

                        NetworkSearchBrain.launchURLCeneo(
                            'https://ceneo.pl/;szukaj-$finalName');
                      },
                      launchURLGoogle: () {
                        String name = items.elementAt(index).name;
                        NetworkSearchBrain.launchURLGoogle(
                            'https://google.com/search?q=Ceneo Amazon $name');
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
