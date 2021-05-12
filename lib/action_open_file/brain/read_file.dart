import 'dart:convert';
import 'dart:io';

import 'package:csv/csv.dart';
import 'package:excel/excel.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';

class ReadFile {
  static List<Product> fileData = [];
  static var bytes;
  static var excel;
  static var imageFile;

  static Future<List<Product>> readFile(var file) async {
    //jeśli to excel
    if (file.toString().contains('xlsx')) {
      fileData = <Product>[];
      bytes = File(file).readAsBytesSync();
      excel = Excel.decodeBytes(bytes);

      for (var table in excel.tables.keys) {
        print('dane tabeli excel(liczba kolumn, liczba wierszy):');
        print(excel.tables[table].maxCols);
        print(excel.tables[table].maxRows);

        String shipment = excel.tables[table]
            .cell(CellIndex.indexByString("F2"))
            .value
            .toString();

        for (int i = 2; i < excel.tables[table].maxRows; i++) {
          if (excel.tables[table]
                  .cell(CellIndex.indexByString("X1"))
                  .value
                  .toString() !=
              "EAN") {
            fileData = null;
            break;
          }

          final product = Product(
              shipmentDate: shipment,
              ASIN: excel.tables[table]
                  .cell(CellIndex.indexByString("V$i"))
                  .value
                  .toString(),
              EAN: excel.tables[table]
                  .cell(CellIndex.indexByString("X$i"))
                  .value
                  .toString(),
              name: excel.tables[table]
                  .cell(CellIndex.indexByString("Z$i"))
                  .value,
              totalRetail: excel.tables[table]
                  .cell(CellIndex.indexByString("AF$i"))
                  .value
                  .toString(),
              LPN: excel.tables[table]
                  .cell(CellIndex.indexByString("AM$i"))
                  .value
                  .toString());
          fileData.add(product);
        }
      }
      return fileData;
      //jeśli to csv
    } else {
      final input = new File(file).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(new CsvToListConverter(
              shouldParseNumbers: false, allowInvalid: true))
          .toList();
      List<dynamic> categoryList = fields.elementAt(0);
      int ASIN;
      int EAN;
      int name;
      int totalRetail;
      int LPN;
      int shipment;
      for (String element in categoryList) {
        if (element.contains('ShipmentClosed')) {
          shipment = categoryList.indexOf(element);
        }
        if (element.contains('ASIN')) {
          ASIN = categoryList.indexOf(element);
        }
        if (element.contains('EAN')) {
          EAN = categoryList.indexOf(element);
        }
        if (element.contains('Item Desc')) {
          name = categoryList.indexOf(element);
        }
        if (element.contains('TOTAL RETAIL')) {
          totalRetail = categoryList.indexOf(element);
        }
        if (element.contains('LPN')) {
          LPN = categoryList.indexOf(element);
        }
      }

      String shipmentDate = fields.elementAt(1).toString().split(',')[5].trim();

      for (int i = 1; i < fields.length; i++) {
        List<dynamic> categoryList = fields.elementAt(i);
        final product = Product(
            shipmentDate: shipmentDate,
            ASIN: categoryList.elementAt(ASIN),
            EAN: categoryList.elementAt(EAN).toString().split('.')[0],
            name: categoryList.elementAt(name),
            totalRetail: categoryList.elementAt(totalRetail),
            LPN: categoryList.elementAt(LPN));
        fileData.add(product);
      }

      return fileData;
    }
  }
}
