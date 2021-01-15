import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_store/brain/mySql.dart';
import 'package:my_store/brain/products_list_brain.dart';
import 'package:my_store/models/product_model.dart';
import 'package:my_store/screens/welcome_screen.dart';
import 'package:my_store/widgets/app_window.dart' as app_window;
import 'package:my_store/widgets/count_min_prices_dialog.dart';
import 'package:my_store/widgets/list_header.dart';
import 'package:my_store/widgets/text_field_my_store.dart';
import 'package:my_store/widgets/whole_list.dart';
import 'package:my_store/widgets/window_buttons.dart';
import 'package:mysql1/mysql1.dart' as mysql;

class Products_Page extends StatefulWidget {
  Products_Page({Key key, this.productsList, this.filePath}) : super(key: key);
  final productsList;
  final filePath;

  @override
  _Products_PageState createState() => new _Products_PageState();
}

class _Products_PageState extends State<Products_Page> {
  TextEditingController editingController = TextEditingController();
  DateTime now = DateTime.now();
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("AppBar Title");
  static var items = <Product>[];
  static String euroRate = '';
  static String newRetail = '';
  static String margin = '';
  static bool dataLoaded;
  static bool loaded;
  ScrollController _controller = ScrollController();
  Product product = new Product();
  bool atAuctionValue = false;
  bool soldValue = false;

  @override
  void initState() {
    dataLoaded = false;
    loaded = false;
    if (widget.filePath == null) {
      items = [];
    }
    items.addAll(widget.productsList);
    if (loaded != null) {
      _checkIfDataAreLoaded();
    }

    super.initState();
    ProductsListBrain.createDBPricesTable();
    _readPricesData();
    _loadExcelDataToDb();
  }

  _checkIfDataAreLoaded() async {
    setState(() {
      print('loaded z checkifDataAreLoaded');
      print(loaded);
      if (loaded) {
        dataLoaded = true;
        print('dataloaded z checkifDataAreLoaded');
        print(dataLoaded);
      } else {
        dataLoaded = false;
        print('dataloaded z checkifDataAreLoaded');
        print(dataLoaded);
      }
    });
  }

  _loadExcelDataToDb() async {
    print("ścieżka przy tworzeniu tabeli excel:");
    print(widget.filePath);
    items = [];
    await items.addAll(widget.productsList);
    loaded = await ProductsListBrain.createDBExcelTable(widget.filePath, items);

    print('loaded:');
    print(loaded);
    if (mounted) {
      setState(() {
        dataLoaded = true;
      });
    }
  }

  _readPricesData() async {
    if (items.isNotEmpty) {
      print(items.elementAt(0).shipmentDate);
      var result = await MySql.readFromPricesTable(
          items.elementAt(0).shipmentDate, await WelcomeScreen.connection);
      print(result.toString());
      //mounted prevents memory leak here
      if (result != null && mounted) {
        setState(() {
          for (var row in result) {
            euroRate = row[0].toString();
            print(euroRate);
            newRetail = row[1].toString();
            margin = row[2].toString();
          }
        });
      }
    }
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
    return WindowBorder(
      color: Colors.black87,
      width: 1,
      child: app_window.AppWindow(
        new Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () async {
                if (loaded != null) await _checkIfDataAreLoaded();
                print('dataloaded when back button clicked:');
                print(dataLoaded);
                Navigator.pop(context, dataLoaded);
              },
            ),
            title: Text('My Store'),
            actions: [
              FlatButton(
                onPressed: () {
                  String myEuro;
                  String myRetail;
                  String myMargin;
                  showDialog(
                    context: context,
                    builder: (BuildContext context) => CountPrices(
                      onChangeEuroValue: (value) {
                        myEuro = value;
                      },
                      euroRate: euroRate,
                      newRetail: newRetail,
                      onChangeNewRetailValue: (value) {
                        myRetail = value;
                      },
                      margin: margin,
                      onChangeMarginValue: (value) {
                        myMargin = value;
                      },
                      onSubmitted: () async {
                        setState(() {
                          if (myEuro != null &&
                              myRetail != null &&
                              myMargin != null) {
                            euroRate = myEuro;
                            newRetail = myRetail;
                            margin = myMargin;
                          }
                        });

                        DateTime date =
                            new DateTime(now.year, now.month, now.day);
                        if (myEuro != null &&
                            myRetail != null &&
                            myMargin != null) {
                          mysql.MySqlConnection connection =
                              await MySql.dBconnection();

                          MySql.insertDataToPrices(
                              connection,
                              euroRate,
                              newRetail,
                              margin,
                              date.toString().substring(0, 10),
                              items.elementAt(0).shipmentDate);
                        }

                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  TextFieldMyStore(
                    onChange: (value) {
                      _filterSearchResults(value, widget.productsList);
                    },
                    textEditingController: editingController,
                    label: "Wyszukaj",
                    hint: "Wyszukaj",
                    leadingIcon: Icon(Icons.search),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListHeaderMyStore(),
                  ),
                  Expanded(
                    child: WholeList(
                      controller: _controller,
                      euroRate: euroRate,
                      newRetail: newRetail,
                      margin: margin,
                      items: items,
                      at_the_auction_check_box: Checkbox(
                        onChanged: (bool value) {
                          setState(() {
                            atAuctionValue = value;
                          });
                        },
                        value: atAuctionValue,
                      ),
                      sold_check_box: Checkbox(
                        onChanged: (bool value) {
                          setState(() {
                            soldValue = value;
                          });
                        },
                        value: soldValue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        WindowButtons(
          closeButtonOnPressed: () async {
            if (loaded != null) _checkIfDataAreLoaded();

            print("czy data loaded?");
            print(dataLoaded);
            if (dataLoaded) {
              ProductsListBrain.closeApp();
            } else {
              String tableName = items
                  .elementAt(0)
                  .shipmentDate
                  .substring(0, 10)
                  .replaceAll('-', '_');
              ProductsListBrain.showAlertBeforeClosing(context, tableName);
            }
          },
        ),
      ),
    );
  }
}
