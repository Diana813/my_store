import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:my_store/list_item.dart';
import 'package:my_store/product_model.dart';
import 'package:my_store/read_excel_file.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController editingController = TextEditingController();

  final productsList = ReadExcelFile.readExcel();
  var items = <Product>[];

  @override
  void initState() {
    items.addAll(productsList);
    super.initState();
  }

  void _filterSearchResults(String query) {
    List<Product> searchedProducts = <Product>[];
    searchedProducts.addAll(productsList);
    if (query.isNotEmpty) {
      List<Product> searchedProductsData = <Product>[];
      searchedProducts.forEach((item) {
        if ((item.EAN != null && item.EAN.toLowerCase().contains(query.toLowerCase())) ||
            (item.name != null && item.name.toLowerCase().contains(query.toLowerCase())) ||
            (item.totalRetail != null && item.totalRetail.toLowerCase().contains(query.toLowerCase())) ||
            (item.LPN != null && item.LPN.toLowerCase().contains(query.toLowerCase()))) {
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
      appBar: new AppBar(
        title: new Text(widget.title),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          )
        ],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    _filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Wyszukaj",
                      hintText: "Wyszukaj",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    return ListItemMyStore(
                        EAN: items.elementAt(index).EAN,
                        name: items.elementAt(index).name,
                        totalRetail: items.elementAt(index).totalRetail,
                        LPN: items.elementAt(index).LPN);
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
