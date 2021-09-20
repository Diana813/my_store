import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_create_offer/models/pricing/selling_mode.dart';

class SellingModePart extends StatefulWidget {
  final SellingMode sellingMode;
  final price;

  SellingModePart({
    @required this.sellingMode,
    @required this.price,
  });

  @override
  State<SellingModePart> createState() => _SellingModePartState();
}

class _SellingModePartState extends State<SellingModePart> {
  TextEditingController priceController;
  TextEditingController minimalPriceController;
  TextEditingController startingPriceController;

  @override
  void initState() {
    priceController = TextEditingController(text: widget.price);
    minimalPriceController = TextEditingController();
    startingPriceController = TextEditingController();
    widget.sellingMode.price.amount = priceController.text;
    widget.sellingMode.format = 'BUY_NOW';
    super.initState();
  }

  @override
  void dispose() {
    if (priceController != null) this.priceController.dispose();
    if (minimalPriceController != null) this.minimalPriceController.dispose();
    if (startingPriceController != null) this.startingPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Forma Sprzedaży',
                  style: TextStyle(color: Color(0xFF89ACBE), fontSize: 18),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RadioListTile<String>(
                      title: const Text('Kup teraz'),
                      value: 'BUY_NOW',
                      groupValue: widget.sellingMode.format,
                      onChanged: (value) {
                        setState(() {
                          widget.sellingMode.format = value;
                          if (value == 'BUY_NOW') {
                            minimalPriceController.text = '0';
                            startingPriceController.text = '0';
                            priceController.text = widget.price;
                            widget.sellingMode.minimalPrice.amount =
                                minimalPriceController.text;
                            widget.sellingMode.startingPrice.amount =
                                startingPriceController.text;
                            widget.sellingMode.price.amount =
                                priceController.text;
                          }
                        });
                      },
                    ),
                    RadioListTile<String>(
                      title: const Text('Licytacja'),
                      value: 'AUCTION',
                      groupValue: widget.sellingMode.format,
                      onChanged: (value) {
                        setState(() {
                          widget.sellingMode.format = value;
                          if (value == 'AUCTION') {
                            minimalPriceController.text = widget.price;
                            startingPriceController.text = widget.price;
                            widget.sellingMode.minimalPrice.amount =
                                minimalPriceController.text;
                            widget.sellingMode.startingPrice.amount =
                                startingPriceController.text;
                            widget.sellingMode.price.amount =
                                priceController.text;
                          }
                        });
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: TextFormField(
                          onChanged: (value) {
                            setState(() {
                              widget.sellingMode.price.amount =
                                  priceController.text;
                            });
                          },
                          controller: priceController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 1,
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Cena, Waluta: PLN',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 0, 0, 0),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          TextFormField(
                            enabled: widget.sellingMode.format == 'BUY_NOW'
                                ? false
                                : true,
                            onChanged: (value) {
                              setState(() {
                                widget.sellingMode.startingPrice.amount =
                                    startingPriceController.text;
                              });
                            },
                            controller: startingPriceController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Cena wywoławcza, Waluta: PLN',
                            ),
                          ),
                          TextFormField(
                            enabled: widget.sellingMode.format == 'BUY_NOW'
                                ? false
                                : true,
                            onChanged: (value) {
                              setState(() {
                                widget.sellingMode.minimalPrice.amount =
                                    minimalPriceController.text;
                              });
                            },
                            controller: minimalPriceController,
                            keyboardType: TextInputType.multiline,
                            maxLines: 1,
                            decoration: InputDecoration(
                              border: UnderlineInputBorder(),
                              labelText: 'Cena minimalna, Waluta: PLN',
                            ),
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ]);
  }
}
