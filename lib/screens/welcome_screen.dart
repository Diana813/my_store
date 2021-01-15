import 'dart:async';

import 'package:appbar_textfield/appbar_textfield.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_store/brain/file_picker_brain.dart';
import 'package:my_store/brain/mySql.dart';
import 'package:my_store/brain/read_excel_file.dart';
import 'package:my_store/brain/welcome_screen_brain.dart';
import 'package:my_store/models/product_model.dart';
import 'package:my_store/utlis/colors.dart';
import 'package:my_store/widgets/raised_button_my_store.dart';
import 'package:mysql1/mysql1.dart' as mysql;

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
  static Future<mysql.MySqlConnection> connection = MySql.dBconnection();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String filePath;
  var items = <Product>[];
  List<String> files = [];
  bool _loading;
  bool thereAreItemsInTheList;
  static var currentDocumentLoaded = null;

  @override
  void initState() {
    filePath = '';
    _loading = false;
    _setFiles();
    super.initState();
  }

  _setFiles() async {
    files = [];
    files = await WelcomeScreenBrain.getFiles(files);
  }

  Future<void> createComputeFunction(String filePath) async {
    items = await compute(computeFunction, filePath);
    setState(() {
      _loading = false;
    });
    if (items == null) {
      WelcomeScreenBrain.showAlertIfFileIsWrong(context);
    } else {
      bool result =
          await WelcomeScreenBrain.goToProductsList(items, context, filePath);
      setState(() {
        currentDocumentLoaded = result;
        print('Result from product list (if current doc loaded)');
        print(currentDocumentLoaded);
        if (result != false) {
          _setFiles();
          thereAreItemsInTheList = true;
        }
      });
    }
  }

  static Future<List<Product>> computeFunction(String filePath) async {
    var response = await ReadExcelFile.readExcel(filePath);
    return response;
  }

  _getFilePathFromPicker() async {
    XFile file = await FilePickerBrain.openTextFile(context);
    setState(() {
      filePath = file.path;
      print("Ścieżka do pliku: " + filePath);
      _loading = true;
    });
    if (filePath != '') {
      createComputeFunction(filePath);
    }
  }

  _checkIfFileListItemsIsEmpty() {
    bool withItems;
    if (files.isNotEmpty) {
      withItems = true;
    } else {
      withItems = false;
    }
    setState(() {
      thereAreItemsInTheList = withItems;
      print('Set state on welcome_screen: ');
      print(thereAreItemsInTheList);
    });
  }

  bool _checkIfCurrentDocIsLoaded() {
    return currentDocumentLoaded;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTextField(
        trailingActionButtons: [
          IconButton(
            icon: Icon(Icons.chevron_right),
            onPressed: () async {
              if (items != null) {
                bool result = await WelcomeScreenBrain.goToProductsList(
                    items, context, 'a');
                setState(() {
                  currentDocumentLoaded = result;
                  print('Result from product list (if current doc loaded');
                  print(currentDocumentLoaded);
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
            if (!value.contains('xlsx') && !value.contains('xls')) {
              WelcomeScreenBrain.showAlertIfFileIsWrong(context);
              _loading = false;
            } else if (value.startsWith('"')) {
              filePath = value.replaceAll("\"", "");
              _loading = true;
            } else {
              filePath = value;
              _loading = true;
            }
            print("Ścieżka do pliku: " + filePath);
          });
          if (filePath != '') {
            createComputeFunction(filePath);
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
                    currentDocumentLoaded = _checkIfCurrentDocIsLoaded();
                    print('currentdocLoaded:');
                    print(currentDocumentLoaded);
                    WelcomeScreenBrain.openFilesList(
                        context,
                        files,
                        thereAreItemsInTheList,
                        items,
                        filePath,
                        currentDocumentLoaded);
                  },
                  childWidget: Text(
                    'Wybierz plik',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
