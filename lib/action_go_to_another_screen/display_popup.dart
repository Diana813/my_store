import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_mysql/items_table.dart';
import 'package:my_store/widgets/popup_dialog.dart';

class DisplayPopUp {
  static bool _downloadingImages = false;
  static bool _savingItemsToDb = false;
  static bool _stopDownloadingImages = false;

  static bool get stopDownloadingImages => _stopDownloadingImages;

  static set stopDownloadingImages(bool value) {
    _stopDownloadingImages = value;
  }

  static bool get downloadingImages => _downloadingImages;

  static bool get savingItemsToDb => _savingItemsToDb;

  static set savingItemsToDb(bool value) {
    _savingItemsToDb = value;
  }

  static set downloadingImages(bool value) {
    _downloadingImages = value;
  }

  static displayPopup(
      BuildContext context, String tableName, Function goWhereYouNeed) async {
    if (_downloadingImages) {
      showAlertBeforeClosing(
          context,
          'Jeśli opuścisz tę stronę nie wszystkie obrazki zostaną pobrane i zapisane',
          'Opuść stronę mimo to',
          tableName,
          goWhereYouNeed);
    } else if (_savingItemsToDb) {
      showAlertBeforeClosing(
          context,
          'Jeśli opuścisz tę stronę tabela nie zostanie zapisana',
          'Opuść stronę mimo to',
          tableName,
          goWhereYouNeed);
    }
  }

  static showAlertBeforeClosing(BuildContext context, String alert,
      String buttonName, String tableName, Function onPressedContinue) {
    showDialog(
      context: context,
      builder: (context) => PopUpDialog(
        message: 'Trwa zapisywanie do bazy danych.',
        advice: alert,
        textButton: buttonName,
        onPressedContinue: onPressedContinue,
      ),
    );
  }

  static leavePageWhileDownloadingImages(
      Function goWhereYouNeed, BuildContext context) {
    Navigator.pop(context);
    goWhereYouNeed;
  }

  static leavePageWhileSavingTableInDb(
      String tableName, Function goWhereYouNeed, BuildContext context) {
    Navigator.pop(context);
    ItemsTable.deleteTable(tableName);
    goWhereYouNeed;
  }

  static goBackWhileDownloadingImages(
      Function goWhereYouNeed, BuildContext context) {
    goWhereYouNeed;
  }

  static goBackWhileSavingTableInDb(
      String tableName, Function goWhereYouNeed, BuildContext context) {
    ItemsTable.deleteTable(tableName);
    goWhereYouNeed;
  }

  static gotoAnotherScreen(tableName, BuildContext context, Function navigation) {
    if (savingItemsToDb) {
      savingItemsToDb = false;
      leavePageWhileSavingTableInDb(tableName, navigation, context);
    } else {
      leavePageWhileDownloadingImages(navigation, context);
    }
    return true;
  }

  static goBack(tableName, BuildContext context, Function navigation) {
    if (DisplayPopUp.savingItemsToDb) {
      savingItemsToDb = false;
      goBackWhileSavingTableInDb(tableName, navigation, context);
    } else {
      stopDownloadingImages = true;
      goBackWhileDownloadingImages(navigation, context);
    }
  }
}
