import 'dart:io';
import 'package:excel/excel.dart';
import 'package:my_store/models/product_model.dart';

class ReadExcelFile {
  static List<Product> readExcel(var file) {
    List<Product> excelData = <Product>[];
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      print(table); //sheet Name
      print(excel.tables[table].maxCols);
      print(excel.tables[table].maxRows);

      for (int i = 2; i < excel.tables[table].maxRows; i++) {
        if (excel.tables[table]
            .cell(CellIndex.indexByString("X1"))
            .value
            .toString() !=
            "EAN") {
          excelData = null;
          break;
        }
        final product = Product(
            isDone: false,
            ASIN: excel.tables[table]
                .cell(CellIndex.indexByString("V$i"))
                .value
                .toString(),
            EAN: excel.tables[table]
                .cell(CellIndex.indexByString("X$i"))
                .value
                .toString(),
            name:
                excel.tables[table].cell(CellIndex.indexByString("Z$i")).value,
            totalRetail: excel.tables[table]
                .cell(CellIndex.indexByString("AF$i"))
                .value
                .toString(),
            LPN: excel.tables[table]
                .cell(CellIndex.indexByString("AM$i"))
                .value
                .toString());
        excelData.add(product);
      }
    }

    return excelData;
  }
}
