import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitlePart extends StatelessWidget {
  final TextEditingController nameController;

  TitlePart({
    @required this.nameController,
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
                  'Tytuł oferty',
                  style: TextStyle(color: Color(0xFF89ACBE), fontSize: 18),
                ),
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  maxLength: 50,
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
