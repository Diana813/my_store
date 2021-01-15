import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/widgets/text_field_my_store.dart';

class CountPrices extends StatelessWidget {
  final Function onChangeEuroValue;
  final String euroRate;
  final Function onChangeNewRetailValue;
  final String newRetail;
  final Function onChangeMarginValue;
  final String margin;
  final Function onSubmitted;

  CountPrices(
      {@required this.onChangeEuroValue,
      @required this.euroRate,
      @required this.newRetail,
      @required this.onChangeNewRetailValue,
      @required this.margin,
      @required this.onChangeMarginValue,
      @required this.onSubmitted});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Oblicz ceny minimalne'),
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldMyStore(
                label: 'Kurs Euro',
                hint: 'np. 3.50',
                counterText:
                    euroRate == '' ? null : "Ostatnio " + euroRate + " €",
                onChange: onChangeEuroValue),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldMyStore(
                label: 'Cena zakupu w procentach',
                hint: 'np. 30',
                counterText:
                    newRetail == '' ? null : "Ostatnio " + newRetail + " %",
                onChange: onChangeNewRetailValue),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFieldMyStore(
                label: 'Marża w procentach',
                hint: 'np. 300',
                counterText: margin == '' ? null : "Ostatnio " + margin + " %",
                onChange: onChangeMarginValue),
          ),
        ],
      ),
      actions: <Widget>[
        new FlatButton(
          onPressed: onSubmitted,
          textColor: Theme.of(context).primaryColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: const Text('Zatwierdź'),
          ),
        ),
      ],
    );
  }
}
