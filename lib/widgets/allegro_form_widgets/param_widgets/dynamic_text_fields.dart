import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';
import 'package:my_store/action_create_offer/offer_param.dart';
import 'package:my_store/utils/colors.dart';

class ParameterTextField extends StatefulWidget {
  final String EAN;
  final OfferParameter param;
  final List<ParameterToPost> myOfferParametersList;
  final List<Parameter> productParameters;
  final bool canChangeParameter;

  ParameterTextField({
    @required this.EAN,
    @required this.param,
    @required this.myOfferParametersList,
    @required this.productParameters,
    @required this.canChangeParameter,
  });

  @override
  _ParameterTextField createState() => _ParameterTextField();
}

class _ParameterTextField extends State<ParameterTextField> {
  FocusNode myFocusNode;
  String controllerText;
  bool doneBool;

  @override
  void initState() {
    super.initState();
    myFocusNode = FocusNode();
    Parameter productParam = null;
    var productParams = widget.productParameters
        .where((element) => element.id == widget.param.id);
    if (productParams.isNotEmpty) {
      productParam = productParams.first;
    }

    if (widget.productParameters != null && productParam != null) {
      doneBool = true;
      controllerText = productParam.values.first;
      var contain = widget.myOfferParametersList
          .where((element) => element.id == widget.param.id);
      if (contain.isEmpty) {
        widget.myOfferParametersList.add(new ParameterToPost(
            id: widget.param.id,
            valuesIds: [],
            values: [controllerText],
            rangeValue: null));
      } else {
        contain.first.values = [controllerText];
      }
    } else {
      controllerText = '';
      doneBool = false;
      if (widget.EAN != null) {
        controllerText = widget.EAN;
        doneBool = true;
        var contain = widget.myOfferParametersList
            .where((element) => element.id == widget.param.id);
        if (contain.isEmpty) {
          widget.myOfferParametersList.add(new ParameterToPost(
              id: widget.param.id,
              valuesIds: [],
              values: [widget.EAN],
              rangeValue: null));
        } else {
          contain.first.values = [widget.EAN];
        }
      }
    }
  }

  @override
  void dispose() {
    if (myFocusNode != null) myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              enabled: widget.canChangeParameter,
              initialValue: controllerText,
              style: TextStyle(
                  color: widget.canChangeParameter
                      ? OfferParam.validateInput(controllerText, widget.param)
                      : Colors.grey),
              onChanged: (value) {
                var contain = widget.myOfferParametersList
                    .where((element) => element.id == widget.param.id);
                if (contain.isEmpty) {
                  widget.myOfferParametersList.add(new ParameterToPost(
                      id: widget.param.id,
                      valuesIds: [],
                      values: [value],
                      rangeValue: null));
                } else {
                  contain.first.values = [value];
                }
                setState(() {
                  controllerText = value;
                  if (value.isNotEmpty) {
                    doneBool = true;
                  } else {
                    doneBool = false;
                  }
                });
              },
              textInputAction: TextInputAction.next,
              maxLines: 1,
              maxLength: widget.param.restrictions.maxLength == null
                  ? null
                  : widget.param.restrictions.maxLength,
              decoration: InputDecoration(
                labelText: OfferParam.createHintString(widget.param),
              ),
              inputFormatters: OfferParam.setInputFormatters(widget.param),
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
