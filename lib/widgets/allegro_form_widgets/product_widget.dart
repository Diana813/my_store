import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utils/colors.dart';

class ProductPart extends StatelessWidget {
  final bool bindingVisible;
  final bool bindWithProduct;
  final String addProductQuestion;
  final Function onBindWithProductChange;

  ProductPart({
    @required this.bindingVisible,
    @required this.bindWithProduct,
    @required this.addProductQuestion,
    @required this.onBindWithProductChange
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Visibility(
            child: CheckboxListTile(
              value: bindWithProduct,
              onChanged: onBindWithProductChange,
              title: Text(
                addProductQuestion,
                style: TextStyle(
                    color: Color(ColorsMyStore.PrimaryColor), fontSize: 18),
              ),
            ),
            visible: bindingVisible,
          ),
        ]);
  }
}