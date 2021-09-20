import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/action_create_offer/offer_param.dart';
import 'package:my_store/utils/colors.dart';

class StockPart extends StatefulWidget {
  final OfferModel offerModel;

  StockPart({@required this.offerModel});

  @override
  _StockPartState createState() => _StockPartState();
}

class _StockPartState extends State<StockPart> {
  String choiceValue;
  List<String> itemsList = ['Sztuk', 'Kompletów', 'Par'];

  @override
  void initState() {
    super.initState();
    choiceValue = itemsList.first;
    widget.offerModel.stock.available = 1;
    widget.offerModel.stock.unit = 'UNIT';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Text(
            'Ilość',
            style: TextStyle(color: Color(0xFF89ACBE), fontSize: 18),
          ),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(14.0, 0, 8, 0),
              child: TextFormField(
                initialValue: '1',
                onChanged: (value) {
                  widget.offerModel.stock.available = int.parse(value);
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(0.0),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))
                ],
              ),
            )),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8, 0, 14, 0),
                child: DropdownButtonFormField<String>(
                    decoration:
                        InputDecoration(contentPadding: EdgeInsets.all(0.0)),
                    isExpanded: true,
                    value: choiceValue,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Color(ColorsMyStore.AccentColor),
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: const TextStyle(color: Colors.black),
                    onChanged: (value) {
                      setState(() {
                        choiceValue = value;
                        if (value == 'Sztuk') {
                          widget.offerModel.stock.unit = 'UNIT';
                        } else if (value == 'Kompletów') {
                          widget.offerModel.stock.unit = 'SET';
                        } else {
                          widget.offerModel.stock.unit = 'PAIR';
                        }
                      });
                    },
                    items:
                        itemsList.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 16),
                        ),
                      );
                    }).toList()),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
