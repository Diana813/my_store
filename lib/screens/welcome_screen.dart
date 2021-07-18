import 'dart:async';

import 'package:appbar_textfield/appbar_textfield.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_store/action_display_list_of_items/brain/products_list_brain.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/action_mysql/items_table.dart';
import 'package:my_store/action_mysql/mySql.dart';
import 'package:my_store/action_mysql/my_offers_table.dart';
import 'package:my_store/action_open_file/brain/file_picker_brain.dart';
import 'package:my_store/action_open_file/brain/read_file.dart';
import 'package:my_store/action_open_file/brain/welcome_screen_brain.dart';
import 'package:my_store/utils/colors.dart';
import 'package:my_store/widgets/popup_files_list.dart';
import 'package:my_store/widgets/raised_button_my_store.dart';
import 'package:mysql1/mysql1.dart' as mysql;

class WelcomeScreen extends StatefulWidget {
  WelcomeScreen({Key key, this.tableName}) : super(key: key);
  String filePath;
  String tableName;

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  static Future<mysql.MySqlConnection> connection;
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  var items = <Product>[];
  List<String> files = [];
  bool _loading;
  bool thereAreItemsInTheList;
  bool listOfFilestIsNotEmpty;

  @override
  void initState() {
    MySql.dBconnection();
    MyOffersTable.createTableMyOffer();
    _loading = false;
    _setFiles();

    super.initState();
  }

  _setFiles() async {
    files = [];
    files = await WelcomeScreenBrain.getFiles();
  }

  Future<void> createComputeFunction(String filePath) async {
    items = await compute(computeFunction, filePath);
    setState(() {
      _loading = false;
    });
    if (items == null) {
      WelcomeScreenBrain.showAlertIfFileIsWrong(context);
    } else {
      bool result = await WelcomeScreenBrain.goToProductsList(
          items, context, filePath, ProductsListBrain.getItemsTableName(items));
      setState(() {
        if (result != false) {
          _setFiles();
          thereAreItemsInTheList = true;
        }
      });
    }
  }

  static Future<List<Product>> computeFunction(String filePath) async {
    var response = await ReadFile.readFile(filePath);
    return response;
  }

  _getFilePathFromPicker() async {
    String filePath = await FilePickerBrain.openText();
    if (filePath == null) {
      return;
    }
    setState(() {
      widget.filePath = filePath;
      _loading = true;
    });
    if (widget.filePath != '') {
      createComputeFunction(widget.filePath);
    }
  }

  _checkIfFileListItemsIsEmpty() {
    if (files != null && files.isNotEmpty) {
      listOfFilestIsNotEmpty = true;
    } else {
      listOfFilestIsNotEmpty = false;
    }
    setState(() {
      thereAreItemsInTheList = listOfFilestIsNotEmpty;
    });
  }

  _openFilesList(BuildContext context, List<String> files,
      bool thereAreItemsInTheList, List<Product> items, String filePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PopUpDialogList(
        context: context,
        message: 'Wybierz plik z listy',
        filesList: files,
        listIsNotEmpty: thereAreItemsInTheList,
        listWidget: ListView.builder(
          shrinkWrap: true,
          itemCount: files.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Icon(
                Icons.done,
                color: MaterialColor(
                    ColorsMyStore.AccentColor, ColorsMyStore.color),
              ),
              title: Text(files.elementAt(index)),
              onTap: () async {
                widget.tableName = files.elementAt(index);
                widget.filePath = null;
                items =
                    await ItemsTable.readItemsDataFromDBTable(widget.tableName);
                Navigator.pop(context);
                WelcomeScreenBrain.goToProductsList(
                    items, context, filePath, files.elementAt(index));
              },
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTextField(
        trailingActionButtons: [
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () async {
              if (widget.filePath != null) {
                items = await compute(computeFunction, widget.filePath);
                print(widget.filePath);
                print(items.length);
              } else if (widget.tableName != null) {
                items =
                    await ItemsTable.readItemsDataFromDBTable(widget.tableName);
                print(widget.tableName);
                print(items.length);
              } else {
                items == null;
              }
              if (items != null) {
                print(items.length);
                String tableName = ProductsListBrain.getItemsTableName(items);
                /* if (tableName == null) {
                  return;
                }*/
                bool result = await WelcomeScreenBrain.goToProductsList(
                    items, context, widget.filePath, tableName);
                setState(() {
                  if (result != false) {
                    _setFiles();
                    thereAreItemsInTheList = true;
                  }
                });
              }
            },
          ),
        ],
        defaultHintText: 'Podaj ścieżkę do pliku',
        searchContainerColor:
            MaterialColor(ColorsMyStore.AccentColor, ColorsMyStore.color),
        backgroundColor:
            MaterialColor(ColorsMyStore.PrimaryColor, ColorsMyStore.color),
        searchButtonIcon: Icon(
          Icons.add,
          semanticLabel: 'Otwórz plik',
        ),
        onSubmitted: (value) async {
          setState(() {
            if (!value.contains('xlsx') && !value.contains('csv')) {
              WelcomeScreenBrain.showAlertIfFileIsWrong(context);
              _loading = false;
            } else if (value.startsWith('"')) {
              widget.filePath = value.replaceAll("\"", "");
              _loading = true;
            } else {
              widget.filePath = value;
              _loading = true;
            }
            print("Ścieżka do pliku: " + widget.filePath);
          });
          if (widget.filePath != null) {
            createComputeFunction(widget.filePath);
          }
        },
        title: Text('My Store'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: _loading,
        progressIndicator: CircularProgressIndicator(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 255,
                    height: 255,
                    child: Image.asset('assets/images/file.png')),
                RaisedButtonMyStore(
                  paddingHorizontal: 50,
                  paddingVertical: 20,
                  onClick: _getFilePathFromPicker,
                  childWidget: Text(
                    'Dodaj plik',
                    style: TextStyle(fontSize: 18),
                  ),
                  color: Color(ColorsMyStore.AccentColor),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 255,
                    height: 255,
                    child: Image.asset('assets/images/lista.jpg')),
                RaisedButtonMyStore(
                    paddingHorizontal: 50,
                    paddingVertical: 20,
                    onClick: () {
                      _checkIfFileListItemsIsEmpty();
                      if (listOfFilestIsNotEmpty == false) {
                        _setFiles();
                        listOfFilestIsNotEmpty = true;
                      }
                      _openFilesList(context, files, thereAreItemsInTheList,
                          items, widget.filePath);
                    },
                    childWidget: Text(
                      'Wybierz plik',
                      style: TextStyle(fontSize: 18),
                    ),
                    color: Color(ColorsMyStore.AccentColor)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
