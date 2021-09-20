import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';
import 'package:my_store/action_create_offer/offer_param.dart';
import 'package:my_store/utils/colors.dart';

class SingleChoiceDictionaryParam extends StatefulWidget {
  final OfferParameter param;
  final List<String> itemsList;
  final List<ParameterToPost> myOfferParametersList;
  final List<Parameter> productParameters;
  final bool canChangeParameter;

  SingleChoiceDictionaryParam({
    @required this.itemsList,
    @required this.param,
    @required this.myOfferParametersList,
    @required this.productParameters,
    @required this.canChangeParameter,
  });

  @override
  _SingleChoiceDictionaryParamState createState() =>
      _SingleChoiceDictionaryParamState();
}

class _SingleChoiceDictionaryParamState
    extends State<SingleChoiceDictionaryParam> {
  String choiceValue;
  Color underlineColor;
  double underlineThickness;
  bool doneBool;
  var contain;
  String textFieldValue = '';
  bool visible = false;

  @override
  void initState() {
    super.initState();
    Parameter productParam = null;
    var productParams = widget.productParameters
        .where((element) => element.id == widget.param.id);
    if (productParams.isNotEmpty) {
      productParam = productParams.first;
    }

    if (widget.productParameters != null && productParam != null) {
      choiceValue = productParam.values_label.first;
      if(productParam.valuesIds.first == widget.param.options.ambiguousValueId){
        choiceValue = choiceValue.split(' ')[0];
        setState(() {
          textFieldValue = productParam.values.first;
        });
      }
      underlineColor = Colors.grey;
      underlineThickness = 1;
      //sprawdza czy lista parametrów myOffer zawiera już ten parametr
      contain = widget.myOfferParametersList
          .where((element) => element.id == widget.param.id);
      if (contain.isEmpty) {
        widget.myOfferParametersList.add(new ParameterToPost(
            id: widget.param.id,
            valuesIds: [getValuesIds(productParam)],
            values: [],
            rangeValue: null));

        if (productParam.valuesIds.first == widget.param.options.ambiguousValueId &&
            widget.param.options.customValuesEnabled == true) {
          contain.first.valuesIds = [productParam.id];
          contain.first.values = [productParam.values.first];
        }
      } else {
        contain.first.valuesIds = [
          widget.param.dictionary
              .where((element) => element.value == choiceValue)
              .first
              .id
        ];

        if (productParam.valuesIds.first ==
                widget.param.options.ambiguousValueId &&
            widget.param.options.customValuesEnabled == true) {
          contain.first.values = widget.param.dictionary
              .where((element) => element.value == choiceValue)
              .first
              .value;
        }
      }
      doneBool = true;
    } else {
      choiceValue = widget.itemsList.first;
      underlineColor = Color(ColorsMyStore.PrimaryColor);
      underlineThickness = 2;
      doneBool = false;
    }
  }

  getValuesIds(var productParam) {
    if (widget.param.options.ambiguousValueId != productParam.valuesIds.first) {
      return widget.param.dictionary
          .where((element) => element.value == choiceValue)
          .first
          .id;
    } else {
      return productParam.valuesIds.first;
    }
  }

  checkIfChoiceIsAmbiguous(String value) {
    int index = widget.itemsList.indexOf(value);

    if (widget.param.dictionary.elementAt(index).id ==
            widget.param.options.ambiguousValueId &&
        widget.param.options.customValuesEnabled == true) {
      visible = true;
      return Visibility(
        visible: visible,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  enabled: widget.canChangeParameter,
                  style: TextStyle(
                      color: widget.canChangeParameter
                          ? OfferParam.validateInput(
                              textFieldValue, widget.param)
                          : Colors.grey),
                  decoration: InputDecoration(
                      labelText: OfferParam.createHintString(widget.param)),
                  inputFormatters: OfferParam.setInputFormatters(widget.param),
                  initialValue: textFieldValue,
                  onChanged: (v) {
                    contain.first.values = [v];
                    setState(() {
                      textFieldValue = v;
                    });
                  },
                ),
              ),
              Container(width: 20)
            ],
          ),
        ),
      );
    } else {
      visible = false;
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            child: Row(
              children: [
                Expanded(
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
                        height: underlineThickness,
                        color: underlineColor,
                      ),
                      onChanged: widget.canChangeParameter
                          ? (value) {
                              setState(() {
                                choiceValue = value;
                                underlineColor = Colors.grey;
                                underlineThickness = 1;
                                doneBool = true;
                              });
                              int index = widget.itemsList.indexOf(value);
                              contain = widget.myOfferParametersList.where(
                                  (element) => element.id == widget.param.id);
                              if (contain.isEmpty) {
                                widget.myOfferParametersList.add(
                                    new ParameterToPost(
                                        id: widget.param.id,
                                        valuesIds: [
                                          widget.param.dictionary
                                              .elementAt(index)
                                              .id
                                        ],
                                        values: [],
                                        rangeValue: null));
                              } else {
                                contain.first.valuesIds = [
                                  widget.param.dictionary.elementAt(index).id
                                ];
                              }
                            }
                          : null,
                      items: widget.itemsList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList()),
                ),
                Container(
                  width: 20,
                  child: Visibility(
                    visible: doneBool,
                    child: Icon(
                      Icons.done,
                      color: Color(ColorsMyStore.AccentColor),
                    ),
                  ),
                ),
              ],
            )),
        checkIfChoiceIsAmbiguous(choiceValue)
      ],
    );
    ;
  }
}
