import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';
import 'package:my_store/action_create_offer/models/range.dart';
import 'package:my_store/action_create_offer/offer_param.dart';
import 'package:my_store/utils/colors.dart';

class RangeParameter extends StatefulWidget {
  final OfferParameter param;
  final List<ParameterToPost> myOfferParametersList;
  final List<Parameter> productParameters;
  final bool canChangeParameter;

  RangeParameter({
    @required this.param,
    @required this.myOfferParametersList,
    @required this.productParameters,
    @required this.canChangeParameter,
  });

  @override
  _RangeParameterState createState() => _RangeParameterState();
}

class _RangeParameterState extends State<RangeParameter> {
  String inputFrom;
  String inputTo;
  bool doneBool;

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
      inputFrom = productParam.rangeValue.from;
      inputTo = productParam.rangeValue.to;
      var contain = widget.myOfferParametersList
          .where((element) => element.id == widget.param.id);
      if (contain.isEmpty) {
        widget.myOfferParametersList.add(new ParameterToPost(
            id: widget.param.id,
            valuesIds: [],
            values: [],
            rangeValue: new RangeValue(from: inputFrom, to: inputTo)));
      } else {
        contain.first.rangeValue.from = inputFrom;
        contain.first.rangeValue.to = inputTo;
      }
      doneBool = true;
    } else {
      inputFrom = '';
      inputTo = '';
      doneBool = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Min: '),
                Expanded(
                  child: TextFormField(
                    enabled: widget.canChangeParameter,
                    initialValue: inputFrom,
                    style: TextStyle(
                        color: widget.canChangeParameter
                            ? OfferParam.validateInput(inputTo, widget.param)
                            : Colors.grey),
                    onChanged: widget.canChangeParameter
                        ? (value) {
                            var contain = widget.myOfferParametersList.where(
                                (element) => element.id == widget.param.id);
                            if (contain.isEmpty) {
                              widget.myOfferParametersList.add(new ParameterToPost(
                                  id: widget.param.id,
                                  valuesIds: [],
                                  values: [],
                                  rangeValue: new RangeValue(from: value)));
                            } else {
                              contain.first.rangeValue.from = value;
                            }
                            setState(() {
                              inputFrom = value;
                              if (contain.last.rangeValue.from.isNotEmpty &&
                                  contain.last.rangeValue.to.isNotEmpty) {
                                doneBool = true;
                              } else {
                                doneBool = false;
                              }
                            });
                          }
                        : null,
                    inputFormatters:
                        OfferParam.setInputFormatters(widget.param),
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: widget.param.unit == null
                          ? widget.param.restrictions.min.toString()
                          : widget.param.restrictions.min.toString() +
                              ' ' +
                              widget.param.unit,
                    ),
                  ),
                ),
                Text('Max: '),
                Expanded(
                  child: TextFormField(
                    enabled: widget.canChangeParameter,
                    initialValue: inputTo,
                    style: TextStyle(
                        color: widget.canChangeParameter
                            ? OfferParam.validateInput(inputTo, widget.param)
                            : Colors.grey),
                    onChanged: (value) {
                      var contain = widget.myOfferParametersList
                          .where((element) => element.id == widget.param.id);
                      if (contain.isEmpty) {
                        widget.myOfferParametersList.add(new ParameterToPost(
                            id: widget.param.id,
                            valuesIds: [],
                            values: [],
                            rangeValue: new RangeValue(to: value)));
                      } else {
                        contain.first.rangeValue.to = value;
                      }
                      setState(() {
                        inputTo = value;
                        if (contain.last.rangeValue.from.isNotEmpty &&
                            contain.last.rangeValue.to.isNotEmpty) {
                          doneBool = true;
                        } else {
                          doneBool = false;
                        }
                      });
                    },
                    inputFormatters:
                        OfferParam.setInputFormatters(widget.param),
                    maxLines: 1,
                    decoration: InputDecoration(
                      labelText: widget.param.unit == null
                          ? widget.param.restrictions.max.toString()
                          : widget.param.restrictions.max.toString() +
                              ' ' +
                              widget.param.unit,
                    ),
                  ),
                ),
              ],
            ),
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
      ),
    );
  }
}
