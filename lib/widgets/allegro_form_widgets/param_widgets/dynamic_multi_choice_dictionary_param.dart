import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';

class MultiChoiceDictionaryParam extends StatefulWidget {
  final List<String> items;
  final List<ParameterToPost> myOfferParametersList;
  final OfferParameter param;
  final List<Parameter> productParameters;
  final bool canChangeParameter;

  MultiChoiceDictionaryParam({
    @required this.items,
    @required this.myOfferParametersList,
    @required this.param,
    @required this.productParameters,
    @required this.canChangeParameter,
  });

  @override
  _MultiChoiceDictionaryParamState createState() =>
      _MultiChoiceDictionaryParamState();
}

class _MultiChoiceDictionaryParamState
    extends State<MultiChoiceDictionaryParam> {
  List<bool> dictionaryCheckBoxValues = [];
  List<String> parametersIds = [];

  createCheckBoxValuesList() {
    Parameter productParam = null;
    var productParams = widget.productParameters
        .where((element) => element.id == widget.param.id);
    if (productParams.isNotEmpty) {
      productParam = productParams.first;
    }
    List<bool> values = [];
    for (int i = 0; i < widget.items.length; i++) {
      if (productParam != null &&
          productParam.valuesIds
              .where((element) =>
                  element ==
                  widget.param.dictionary
                      .where((element) =>
                          element.value == widget.items.elementAt(i))
                      .first
                      .id)
              .isNotEmpty) {
        values.add(true);
        parametersIds.add(widget.param.dictionary
            .elementAt(i)
            .id);
      } else {
        values.add(false);
      }
    }

    var contain = widget.myOfferParametersList
        .where((element) =>
    element.id == widget.param.id);
    if (contain.isEmpty) {
      widget.myOfferParametersList.add(
          new ParameterToPost(
              id: widget.param.id,
              valuesIds: parametersIds,
              values: [],
              rangeValue: null));
    } else {
      contain.first.valuesIds = parametersIds;
    }
    return values;
  }

  @override
  void initState() {
    dictionaryCheckBoxValues = createCheckBoxValuesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              itemCount: widget.items.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.items.elementAt(index),
                      style: TextStyle(fontSize: 16),
                    ),
                    Checkbox(
                        value: dictionaryCheckBoxValues[index],
                        onChanged: widget.canChangeParameter
                            ? (value) {
                                setState(() {
                                  dictionaryCheckBoxValues[index] = value;
                                });

                                if (value) {
                                  parametersIds.add(widget.param.dictionary
                                      .elementAt(index)
                                      .id);
                                } else {
                                  parametersIds.removeAt(index);
                                }

                                var contain = widget.myOfferParametersList
                                    .where((element) =>
                                        element.id == widget.param.id);
                                if (contain.isEmpty) {
                                  widget.myOfferParametersList.add(
                                      new ParameterToPost(
                                          id: widget.param.id,
                                          valuesIds: parametersIds,
                                          values: [],
                                          rangeValue: null));
                                } else {
                                  contain.first.valuesIds = parametersIds;
                                }
                              }
                            : null),
                  ],
                );
              }),
        ),
        Container(
          width: 20,
        ),
      ],
    );
    ;
  }
}
