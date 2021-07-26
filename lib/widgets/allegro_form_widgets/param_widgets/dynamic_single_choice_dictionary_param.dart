import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';
import 'package:my_store/utils/colors.dart';

class SingleChoiceDictionaryParam extends StatefulWidget {
  final OfferParameter param;
  final List<String> itemsList;
  final List<MyParameter> myOfferParametersList;

  SingleChoiceDictionaryParam({
    @required this.itemsList,
    @required this.param,
    @required this.myOfferParametersList,
  });

  @override
  _SingleChoiceDictionaryParamState createState() =>
      _SingleChoiceDictionaryParamState();
}

class _SingleChoiceDictionaryParamState
    extends State<SingleChoiceDictionaryParam> {
  String choiceValue;

  @override
  void initState() {
    super.initState();
    choiceValue = widget.itemsList.first;
    var contain = widget.myOfferParametersList
        .where((element) => element.id == widget.param.id);
    if (contain.isEmpty) {
      widget.myOfferParametersList.add(new MyParameter(
          id: widget.param.id,
          valuesIds: [widget.param.dictionary.elementAt(0).id],
          values: [],
          rangeValue: null));
    } else {
      contain.first.valuesIds = [widget.param.dictionary.elementAt(0).id];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: DropdownButton<String>(
            isExpanded: true,
            value: choiceValue,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(ColorsMyStore.AccentColor),
            ),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Color(ColorsMyStore.PrimaryColor),
            ),
            onChanged: (value) {
              setState(() {
                choiceValue = value;
              });
              int index = widget.itemsList.indexOf(value);
              var contain = widget.myOfferParametersList
                  .where((element) => element.id == widget.param.id);
              if (contain.isEmpty) {
                widget.myOfferParametersList.add(new MyParameter(
                    id: widget.param.id,
                    valuesIds: [widget.param.dictionary.elementAt(index).id],
                    values: [],
                    rangeValue: null));
              } else {
                contain.first.valuesIds = [
                  widget.param.dictionary.elementAt(index).id
                ];
              }
            },
            items:
                widget.itemsList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(
                  value,
                  style: TextStyle(fontSize: 16),
                ),
              );
            }).toList()));
    ;
  }
}
