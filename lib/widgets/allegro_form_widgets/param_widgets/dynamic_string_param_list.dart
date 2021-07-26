import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';
import 'package:my_store/action_create_offer/offer_param.dart';
import 'package:my_store/utils/colors.dart';

class StringParamList extends StatefulWidget {
  final OfferParameter param;
  final List<MyParameter> myOfferParametersList;

  StringParamList({
    @required this.param,
    @required this.myOfferParametersList,
  });

  @override
  _StringParamListState createState() => _StringParamListState();
}

class _StringParamListState extends State<StringParamList> {
  List<String> propertiesList = [];
  TextEditingController propertiesTextController;
  FocusNode myFocusNode;
  Color iconColor;

  @override
  void initState() {
    super.initState();
    propertiesTextController = new TextEditingController();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    propertiesTextController.dispose();
    myFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            itemCount: propertiesList.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      propertiesList.elementAt(index),
                      style:
                          TextStyle(color: Color(ColorsMyStore.PrimaryColor)),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            propertiesList.removeAt(index);
                          });
                          var contain = widget.myOfferParametersList.where(
                              (element) => element.id == widget.param.id);
                          contain.first.values = propertiesList;
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Color(ColorsMyStore.PrimaryColor),
                          size: 18,
                        ))
                  ],
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
          child: TextFormField(
            focusNode: myFocusNode,
            controller: propertiesTextController,
            onFieldSubmitted: (value) {
              setState(() {
                if (widget.param.restrictions.allowedNumberOfValues >
                    propertiesList.length) {
                  propertiesList.add(value);
                  propertiesTextController.clear();
                }
                myFocusNode.unfocus();
                myFocusNode.requestFocus();
              });

              var contain = widget.myOfferParametersList
                  .where((element) => element.id == widget.param.id);
              if (contain.isEmpty) {
                widget.myOfferParametersList.add(new MyParameter(
                    id: widget.param.id,
                    valuesIds: [],
                    values: propertiesList,
                    rangeValue: null));
              } else {
                contain.first.values = propertiesList;
              }
            },
            maxLength: widget.param.restrictions.maxLength == null
                ? null
                : widget.param.restrictions.maxLength,
            decoration: InputDecoration(
              labelText: OfferParam.createHintString(widget.param),
            ),
          ),
        )
      ],
    );
  }
}
