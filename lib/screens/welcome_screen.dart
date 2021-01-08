import 'dart:async';

import 'package:appbar_textfield/appbar_textfield.dart';
import 'package:file_selector_platform_interface/file_selector_platform_interface.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:my_store/brain/read_excel_file.dart';
import 'package:my_store/models/product_model.dart';
import 'package:my_store/screens/products_list_screen.dart';
import 'package:my_store/utlis/colors.dart';
import 'package:my_store/widgets/popup_dialog.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String filePath;
  var items = <Product>[];
  bool _loading;

  @override
  void initState() {
    filePath = '';
    _loading = false;
    super.initState();
  }

  Future<void> createComputeFunction(String filePath) async {
    items = await compute(computeFunction, filePath);
    setState(() {
      _loading = false;
    });
    if (items == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) => PopUpDialog(
              context: context,
              message: 'Plik zawiera nieprawidłowe dane',
              advice: 'Otwórz inny plik'));
    }else{
      _goToProductsList(items);
    }
  }

  static Future<List<Product>> computeFunction(String filePath) async {
    var response = await ReadExcelFile.readExcel(filePath);
    return response;
  }

  Future<XFile> _openTextFile(BuildContext context) async {
    final XTypeGroup typeGroup = XTypeGroup(
      label: 'Excel files',
      extensions: ['xlsx', 'xls'],
    );
    return await FileSelectorPlatform.instance
        .openFile(acceptedTypeGroups: [typeGroup]);
  }

  _goToProductsList(var items) {
    if (items != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return Products_Page(productsList: items);
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarTextField(
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
            if (value.startsWith('"')) {
              filePath = value.replaceAll("\"", "");
            } else {
              filePath = value;
            }
            print("Ścieżka do pliku: " + filePath);
            _loading = true;
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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/file.png'),
              RaisedButton(
                padding: new EdgeInsets.symmetric(vertical: 20, horizontal: 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
                onPressed: () async {
                  XFile file = await _openTextFile(context);
                  setState(() {
                    filePath = file.path;
                    print("Ścieżka do pliku: " + filePath);
                    _loading = true;
                  });
                  if (filePath != '') {
                    createComputeFunction(filePath);
                  }
                },
                child: Text(
                  "Dodaj plik",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
