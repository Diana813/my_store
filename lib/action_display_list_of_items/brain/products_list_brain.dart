import 'package:flutter/cupertino.dart';
import 'package:my_store/action_display_list_of_items/models/product_model.dart';
import 'package:my_store/action_go_to_another_screen/display_popup.dart';
import 'package:my_store/utlis/navigation.dart';

class ProductsListBrain {
  static getItemsTableName(List<Product> items) {
    if (items.isNotEmpty) {
      String itemsTableName;

      if (items.elementAt(0).shipmentDate.contains('/')) {
        itemsTableName = items
            .elementAt(0)
            .shipmentDate
            .substring(0, 10)
            .replaceAll('/', '_');
      } else if (items.elementAt(0).shipmentDate.contains('.')) {
        itemsTableName = items
            .elementAt(0)
            .shipmentDate
            .substring(0, 10)
            .replaceAll('.', '_');
      } else {
        try {
          itemsTableName = items
              .elementAt(0)
              .shipmentDate
              .substring(0, 10)
              .replaceAll('-', '_');
        } catch (Exception) {
          itemsTableName = items.elementAt(0).shipmentDate;
        }
      }

      return itemsTableName;
    } else {
      return null;
    }
  }

  static String displayMinPrize(
      String euro, String myRetail, String myMargin, String myTotalRetail) {
    if (euro != '' &&
        myRetail != '' &&
        myMargin != '' &&
        myTotalRetail != '' &&
        euro != null &&
        myRetail != null &&
        myMargin != null &&
        myTotalRetail != null &&
        euro != 'null' &&
        myRetail != 'null' &&
        myMargin != 'null' &&
        myTotalRetail != 'null') {
      euro = euro.replaceAll(',', '.');
      myRetail = myRetail.replaceAll(',', '.');
      myMargin = myMargin.replaceAll(',', '.');
      myTotalRetail = myTotalRetail.replaceAll(',', '.');

      double euroRate = double.parse(euro);
      double retail = double.parse(myRetail);
      double margin = double.parse(myMargin);
      double totalRetail = double.parse(myTotalRetail);

      String minPrize =
          (totalRetail * (retail / 100) * euroRate * (margin / 100))
              .toStringAsFixed(2);
      return minPrize;
    } else {
      return '';
    }
  }

  static savingItemsInfo(bool loaded, bool savingData) {
    if (loaded) {
      return 'Tabela jest zapisana w bazie danych';
    } else if (loaded == false && savingData == false) {
      return 'Przerwano zapisywanie tabeli';
    } else {
      return 'Zapisywanie tabeli do bazy danych...';
    }
  }

  static goBackToWelcomeScreen(BuildContext context, String tableName) {
    if (DisplayPopUp.savingItemsToDb == false &&
        DisplayPopUp.downloadingImages == false) {
      Navigator.pop(context);
    } else {
      DisplayPopUp.displayPopup(context, tableName, () {
        DisplayPopUp.goBack(
            tableName,
            context,
            NavigationMyStore.navigationBackToWelcomeScreen(
                context, tableName));
      });
    }
  }
}
