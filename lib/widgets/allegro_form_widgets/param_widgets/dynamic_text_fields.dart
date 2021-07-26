import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';
import 'package:my_store/action_create_offer/offer_param.dart';

class ParameterTextField extends StatefulWidget {
  final String EAN;
  final OfferParameter param;
  final List<MyParameter> myOfferParametersList;

  ParameterTextField({
    @required this.EAN,
    @required this.param,
    @required this.myOfferParametersList,
  });

  @override
  _ParameterTextField createState() => _ParameterTextField();
}

class _ParameterTextField extends State<ParameterTextField> {
  TextEditingController propertiesTextController;
  FocusNode myFocusNode;

  @override
  void initState() {
    super.initState();
    propertiesTextController = new TextEditingController();
    myFocusNode = FocusNode();
    if(widget.EAN != null){
      var contain = widget.myOfferParametersList
          .where((element) => element.id == widget.param.id);
      if (contain.isEmpty) {
        widget.myOfferParametersList.add(new MyParameter(
            id: widget.param.id,
            valuesIds: [],
            values: [widget.EAN],
            rangeValue: null));
      } else {
        contain.first.values = [widget.EAN];
      }
    }
  }

  @override
  void dispose() {
    if (propertiesTextController != null) propertiesTextController.dispose();
    if (myFocusNode != null) myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: TextFormField(
        initialValue: widget.EAN == null ? null : widget.EAN,
        controller: widget.EAN == null ? propertiesTextController : null,
        onFieldSubmitted: (value) {
          var contain = widget.myOfferParametersList
              .where((element) => element.id == widget.param.id);
          if (contain.isEmpty) {
            widget.myOfferParametersList.add(new MyParameter(
                id: widget.param.id,
                valuesIds: [],
                values: [value],
                rangeValue: null));
          } else {
            contain.first.values = [value];
          }
        },
        maxLines: 1,
        maxLength: widget.param.restrictions.maxLength == null
            ? null
            : widget.param.restrictions.maxLength,
        decoration: InputDecoration(
            labelText: OfferParam.createHintString(widget.param)),
      ),
    );
  }
}
