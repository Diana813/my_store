import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:my_store/action_display_list_of_items/brain/display_list.dart';
import 'package:my_store/action_display_list_of_items/brain/products_list_brain.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/action_go_to_another_screen/display_popup.dart';
import 'package:my_store/action_mysql/items_table.dart';
import 'package:my_store/action_mysql/prices_table.dart';
import 'package:my_store/action_post/allegro_api/networking.dart';
import 'package:my_store/action_post/models/products/product.dart';
import 'package:my_store/utlis/navigation.dart';
import 'package:my_store/widgets/app_window.dart' as app_window;
import 'package:my_store/widgets/count_min_prices_dialog.dart';
import 'package:my_store/widgets/list_header.dart';
import 'package:my_store/widgets/popup_allegro_authentication.dart';
import 'package:my_store/widgets/progress_indicator.dart';
import 'package:my_store/widgets/text_field_my_store.dart';
import 'package:my_store/widgets/whole_list_of_items.dart';
import 'package:my_store/widgets/window_buttons.dart';

class Products_Page extends StatefulWidget {
  Products_Page(
      {Key key, this.productsList, this.filePath, this.itemsTableName})
      : super(key: key);
  var productsList;
  final filePath;
  final itemsTableName;

  @override
  _Products_PageState createState() => new _Products_PageState();
}

class _Products_PageState extends State<Products_Page> {
  TextEditingController _editingController = TextEditingController();
  DateTime _now = DateTime.now();
  var _items = <Product>[];
  String _euroRate = '';
  String _newRetail = '';
  String _margin = '';
  ScrollController _controller = ScrollController();
  String _pasted = null;
  bool ifVisible = false;
  double _progress = 0;
  double _howManyItemsSaved = 0;

  bool _loaded;
  String savingItemsInfo;

  @override
  void initState() {
    _displayList();
    super.initState();
    _readPricesData();
    _loadDataToDb();
  }

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Colors.black87,
      width: 1,
      child: app_window.AppWindow(
        Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.chevron_left),
              onPressed: () {
                ProductsListBrain.goBackToWelcomeScreen(
                    context, widget.itemsTableName);
              },
            ),
            title: Text('My Store'),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(ProductsListBrain.savingItemsInfo(
                        _loaded, DisplayPopUp.savingItemsToDb)),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: PopupMenuButton<String>(
                  icon: Icon(Icons.menu),
                  onSelected: (String result) async {
                    switch (result) {
                      case 'Dodaj ceny':
                        String myEuro;
                        String myRetail;
                        String myMargin;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CountPrices(
                            onChangeEuroValue: (value) {
                              myEuro = value;
                            },
                            euroRate: _euroRate,
                            newRetail: _newRetail,
                            onChangeNewRetailValue: (value) {
                              myRetail = value;
                            },
                            margin: _margin,
                            onChangeMarginValue: (value) {
                              myMargin = value;
                            },
                            onSubmitted: () async {
                              if (myEuro != null &&
                                  myRetail != null &&
                                  myMargin != null) {
                                setState(() {
                                  _euroRate = myEuro;
                                  _newRetail = myRetail;
                                  _margin = myMargin;
                                });
                                DateTime date = new DateTime(
                                    _now.year, _now.month, _now.day);
                                await PricesTable.insertDataToPrices(
                                    _euroRate,
                                    _newRetail,
                                    _margin,
                                    date.toString().substring(0, 10),
                                    ProductsListBrain.getItemsTableName(
                                        _items));
                              }

                              Navigator.of(context).pop();
                            },
                          ),
                        );

                        break;
                      case 'Pobierz zdjęcia':
                        tryToDownloadImages(
                            _items, widget.itemsTableName, context);
                        break;
                    }
                  },
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    PopupMenuItem<String>(
                      value: 'Dodaj ceny',
                      child: Text('Dodaj ceny'),
                      enabled: DisplayPopUp.savingItemsToDb ? false : true,
                    ),
                    PopupMenuItem<String>(
                      value: 'Pobierz zdjęcia',
                      child: Text('Pobierz zdjęcia'),
                      enabled: DisplayPopUp.savingItemsToDb ? false : true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          body: Container(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: <Widget>[
                  ProgressIndicatorMyStore(
                      progress: _progress, ifVisible: ifVisible),
                  TextFieldMyStore(
                    onChange: (value) {
                      _filterSearchResults(value, widget.productsList);
                    },
                    textEditingController: _editingController,
                    label: "Wyszukaj",
                    hint: "Wyszukaj",
                    leadingIcon: Icon(Icons.search),
                    clearSearchResult: () {
                      _editingController.clear();
                      setState(() {
                        _items.clear();
                        _items.addAll(widget.productsList);
                      });
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ListHeaderMyStore(),
                  ),
                  Expanded(
                    child: WholeList(
                      controller: _controller,
                      euroRate: _euroRate,
                      newRetail: _newRetail,
                      margin: _margin,
                      items: _items,
                      tableName: widget.itemsTableName,
                      textFieldInitialValue: _pasted,
                      field: _editingController,
                      searchForPastedText: (value) {
                        setState(() {
                          _pasted = value;
                        });
                      },
                      setDownloadingValues: () {
                        setState(() {
                          DisplayPopUp.savingItemsToDb = false;
                          DisplayPopUp.downloadingImages = false;
                          ProductsListBrain.savingItemsInfo(
                              _loaded, DisplayPopUp.savingItemsToDb);
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        WindowButtons(
          closeButtonOnPressed: () async {
            if (DisplayPopUp.savingItemsToDb == false &&
                DisplayPopUp.downloadingImages == false) {
              await NavigationMyStore.closeApp();
            } else {
              DisplayPopUp.displayPopup(context, widget.itemsTableName,
                  () async {
                DisplayPopUp.gotoAnotherScreen(widget.itemsTableName, context,
                    await NavigationMyStore.closeApp());
              });
            }
          },
        ),
      ),
    );
  }

  downloadImageUrls(List<Product> productList, String tableName) async {
    double count = 0;
    for (Product item in productList) {
      if (DisplayPopUp.stopDownloadingImages == true) {
        print('product_list_screen: przerwano pobieranie');
        break;
      }
      String url;
      if (item.EAN == null) {
        url = '';
        int index = productList.indexOf(item) + 1;
        ItemsTable.insertImageUrlData(tableName, index, url);
        continue;
      }
      final response =
          await NetworkHelper.getProductData(item.EAN.split('.')[0]);
      if (response == 'Brak połączenia z Allegro') {
        setState(() {
          ifVisible = false;
          DisplayPopUp.downloadingImages = false;
        });
        break;
      } else {
        setState(() {
          ifVisible = true;
          DisplayPopUp.downloadingImages = true;
        });
      }
      if (!response.toString().contains('images')) {
        url = '';
        int index = productList.indexOf(item) + 1;
        ItemsTable.insertImageUrlData(tableName, index, url);
        continue;
      }
      ProductJson product = ProductJson.fromJson(response);
      if (product.offers != null &&
          product.offers != [] &&
          product.offers[0].photos.isNotEmpty) {
        url = product.offers[0].photos[0].url;
      }
      if (url == null) {
        url = '';
      }
      int index = productList.indexOf(item) + 1;
      ItemsTable.insertImageUrlData(tableName, index, url);
      count++;
      setState(() {
        _progress = count / widget.productsList.length;
      });
    }
    DisplayList.displayImages(tableName);
    setState(() {
      ifVisible = false;
      DisplayPopUp.downloadingImages = false;
    });
    return count;
  }

  Future<bool> tryToDownloadImages(
      var items, String itemsTableName, BuildContext context) async {
    DisplayPopUp.stopDownloadingImages = false;
    double count = await downloadImageUrls(items, itemsTableName);
    if (count == 0) {
      showDialog(
          context: context,
          builder: (BuildContext context) => PopUpAllegroAuth(
                contextValue: context,
              ));
    }
  }

  _displayList() async {
    List<Product> products = await DisplayList.displayList(
        widget.filePath, widget.itemsTableName, widget.productsList);
    _items.addAll(products);
  }

  _loadDataToDb() async {
    bool dataLoaded;
    setState(() {
      _loaded = false;
      DisplayPopUp.savingItemsToDb = true;
      ifVisible = true;
    });
    //jeżeli tabeli nie ma jeszcze w bazie danych, to zapisz
    if (await ItemsTable.checkifTableIsInDb(widget.itemsTableName) == false) {
      for (int i = 0; i < widget.productsList.length; i++) {
        await ItemsTable.addItemToDb(
            widget.productsList, widget.itemsTableName, i);
        setState(() {
          _howManyItemsSaved++;
          _progress = _howManyItemsSaved / widget.productsList.length;
        });
      }
      //kiedy tabela się zapisze, to dataloaded => true
      if (_items.length == _howManyItemsSaved) {
        dataLoaded = true;
      }
    } else {
      //tabela już jest zapisana, więc dataloaded => true
      dataLoaded = true;
    }
    setState(() {
      _loaded = dataLoaded;
      DisplayPopUp.savingItemsToDb = false;
      ifVisible = false;
    });
  }

  _readPricesData() async {
    if (widget.productsList.isNotEmpty) {
      var result = await PricesTable.readFromPricesTable(
          ProductsListBrain.getItemsTableName(widget.productsList));
      setState(() {
        if (result != null) {
          for (var row in result) {
            _euroRate = row[0].toString();
            _newRetail = row[1].toString();
            _margin = row[2].toString();
          }
        }
      });
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
        _items.clear();
        _items.addAll(searchedProductsData);
      });
      return;
    } else {
      setState(() {
        _items.clear();
        _items.addAll(productsList);
      });
    }
  }
}
