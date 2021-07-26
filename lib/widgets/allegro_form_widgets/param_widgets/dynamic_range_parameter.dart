import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';
import 'package:my_store/action_create_offer/models/range.dart';
import 'package:my_store/utils/decimal_text_input.dart';

class RangeParameter extends StatefulWidget {
  final OfferParameter param;
  final List<MyParameter> myOfferParametersList;

  RangeParameter({@required this.param, @required this.myOfferParametersList});

  @override
  _RangeParameterState createState() => _RangeParameterState();
}

class _RangeParameterState extends State<RangeParameter> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text('Min: '),
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                var contain = widget.myOfferParametersList
                    .where((element) => element.id == widget.param.id);
                if (contain.isEmpty) {
                  widget.myOfferParametersList.add(new MyParameter(
                      id: widget.param.id,
                      valuesIds: [],
                      values: [],
                      rangeValue: new RangeValue(from: value)));
                } else {
                  contain.first.rangeValue.from = value;
                }
              },
              inputFormatters: widget.param.type == 'float'
                  ? [
                      widget.param.restrictions.precision == null
                          ? FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9, .]'))
                          : DecimalTextInputFormatter(
                              decimalRange: widget.param.restrictions.precision)
                    ]
                  : [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: widget.param.restrictions.min.toString()),
            ),
          ),
          Text('Max: '),
          Expanded(
            child: TextFormField(
              onChanged: (value) {
                var contain = widget.myOfferParametersList
                    .where((element) => element.id == widget.param.id);
                if (contain.isEmpty) {
                  widget.myOfferParametersList.add(new MyParameter(
                      id: widget.param.id,
                      valuesIds: [],
                      values: [],
                      rangeValue: new RangeValue(to: value)));
                } else {
                  contain.first.rangeValue.to = value;
                }
              },
              inputFormatters: widget.param.type == 'float'
                  ? [
                      widget.param.restrictions.precision == null
                          ? FilteringTextInputFormatter.allow(
                              RegExp(r'[0-9, .]'))
                          : DecimalTextInputFormatter(
                              decimalRange: widget.param.restrictions.precision)
                    ]
                  : [FilteringTextInputFormatter.allow(RegExp(r'[0-9]'))],
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: widget.param.restrictions.max.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
