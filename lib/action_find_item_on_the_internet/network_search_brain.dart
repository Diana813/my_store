import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import 'package:my_store/widgets/popup_dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class NetworkSearchBrain {
  static launchURL(String url) async {
    try {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    } catch (PlatformException) {
      url = url.replaceAll('%', '');
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }

  static checkResponseAmazon(String ASIN, BuildContext context) async {
    List<String> countryCode = ['co.uk', 'it', 'de', 'fr', 'es', 'pl'];

    bool success;
    for (String code in countryCode) {
      String url = 'https://amazon.$code/dp/$ASIN';
      final response = await http.get(url);
      int responseCode = response.statusCode;
      if (responseCode == 200) {
        launchURL(url);
        EasyLoading.dismiss();
        success = true;
        break;
      }
      success = false;
    }

    if (success == false) {
      print('Nie znaleziono produktu w bazie Amazona');
      EasyLoading.dismiss();
      showDialog(
        context: context,
        builder: (BuildContext context) => PopUpDialog(
          context: context,
          message: 'Tego produktu nie ma już w sprzedaży w sklepie Amazon',
          advice: 'Poszukaj w Google',
        ),
      );
    }
  }

  static String findCeneoString(String name) {
    final iReg = RegExp(r'(\d+)');
    String numbers = iReg.allMatches(name).map((m) => m.group(0)).join(' ');

    List<String> num = numbers.split(' ');
    String number = num.elementAt(0);
    String number2 = null;
    if (num.length > 1) {
      number2 = num.elementAt(1);
    }

    List<String> newName = name.split(' ');
    List<String> nameArray = [];

    for (String substring in newName) {
      if (substring.contains(number) && number != '') {
        nameArray.add(substring);
        if (number2 != null &&
            (newName.indexOf(substring) + 1) != newName.length &&
            newName
                .elementAt(newName.indexOf(substring) + 1)
                .contains(number2)) {
          nameArray.add(newName.elementAt(newName.indexOf(substring) + 1));
        }
        break;
      } else {
        nameArray.add(substring);
      }
    }

    String finalName = '';
    for (String string in nameArray) {
      finalName = finalName + string + ' ';
    }

    return finalName;
  }
}
