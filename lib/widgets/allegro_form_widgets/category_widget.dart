import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/utils/colors.dart';

class CategoryPart extends StatelessWidget {

  static int indexOfCategory;
  final String categoryName;
  final String categoryDropDownValue;
  final Function chooseCategory;
  final List<String> categories;
  final bool canBindWithProduct;
  final bool canCreateProduct;
  final bool bindingInfoVisible;
  final Function resetCategory;

  CategoryPart({
    @required this.categoryName,
    @required this.categoryDropDownValue,
    @required this.chooseCategory,
    @required this.categories,
    @required this.canBindWithProduct,
    @required this.canCreateProduct,
    @required this.bindingInfoVisible,
    @required this.resetCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Kategoria produktu',
                  style: TextStyle(color: Color(0xFF89ACBE), fontSize: 18),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton<String>(
                      value: categoryDropDownValue,
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
                      onChanged: chooseCategory,
                      items: categories
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          onTap: () {
                            indexOfCategory = categories.indexOf(value);
                          },
                          value: value,
                          child: Text(
                            value,
                            style: TextStyle(fontSize: 16),
                          ),
                        );
                      }).toList(),
                    ),
                    OutlinedButton(
                      onPressed: resetCategory,
                      child: Text(
                        'Zmień',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ],
                ),
                Text(categoryName,
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(ColorsMyStore.PrimaryColor))),
              ],
            ),
          ),
          Visibility(
            child: CheckboxListTile(
              value: canBindWithProduct,
              onChanged: (bool value) {},
              title: Text('W tej kategorii możesz powiązać ofertę z produktem'),
            ),
            visible: bindingInfoVisible,
          ),
          Visibility(
            child: CheckboxListTile(
              value: canCreateProduct,
              onChanged: (bool value) {},
              title: Text('W tej kategorii możesz utworzyć nowy produkt'),
            ),
            visible: bindingInfoVisible,
          ),
        ]);
  }
}
