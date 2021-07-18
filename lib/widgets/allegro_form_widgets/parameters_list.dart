import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/utils/colors.dart';

class ParametersList extends StatelessWidget {
  List<Parameter> parameters;

  ParametersList({@required this.parameters});

  @override
  Widget build(context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: parameters.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Icon(
              Icons.description,
              color: Color(ColorsMyStore.PrimaryColor),
            ),
            title: Text(parameters.elementAt(index).name),
            subtitle: ListView.builder(
              shrinkWrap: true,
              itemCount: parameters.elementAt(index).values_label.length,
              itemBuilder: (context, inx) {
                return Text(parameters.elementAt(index).values_label[inx]);
              },
            ),
          );
        },
      ),
    );
  }
}
