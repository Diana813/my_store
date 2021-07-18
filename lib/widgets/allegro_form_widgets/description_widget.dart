import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DescriptionPart extends StatelessWidget {
  final TextEditingController descriptionController;

  DescriptionPart({
    @required this.descriptionController,
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
                  'Opis',
                  style: TextStyle(color: Color(0xFF89ACBE), fontSize: 18),
                ),
                TextFormField(
                  controller: descriptionController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Edytuj',
                  ),
                ),
              ],
            ),
          ),
        ]);
  }
}