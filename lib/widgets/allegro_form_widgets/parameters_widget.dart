import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/utils/colors.dart';

import 'parameters_list.dart';

class ParametersPart extends StatelessWidget {
  final String EAN;
  List<Parameter> parameters;
  final OfferModel offer;
  final List<Widget> displayRequiredParams;
  final List<Widget> displayRequiredForProductParams;
  final List<Widget> displayOtherParams;
  final Function getParameters;

  ParametersPart({
    @required this.EAN,
    @required this.parameters,
    @required this.offer,
    @required this.displayRequiredParams,
    @required this.displayRequiredForProductParams,
    @required this.displayOtherParams,
    @required this.getParameters,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton(
              onPressed: getParameters,
              child: Text(
                'Pobierz parametry',
                style: TextStyle(fontSize: 14),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '- Wymagane:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(ColorsMyStore.PrimaryColor),
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: displayRequiredParams,
                ),
                Text(
                  '- Wymagane dla produktu:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(ColorsMyStore.PrimaryColor),
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: displayRequiredForProductParams,
                ),
                Text(
                  '- Inne:',
                  style: TextStyle(
                      fontSize: 16,
                      color: Color(ColorsMyStore.PrimaryColor),
                      fontWeight: FontWeight.bold),
                ),
                Column(
                  children: displayOtherParams,
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              'Parametry',
              style: TextStyle(color: Color(0xFF89ACBE), fontSize: 18),
            ),
            subtitle: ParametersList(
              parameters: parameters,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'EAN',
                  style: TextStyle(color: Color(0xFF89ACBE), fontSize: 18),
                ),
                TextFormField(
                  initialValue: EAN,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Edytuj',
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}
