import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_post/models/offer.dart';

class ItemDetailsList extends StatelessWidget {
  final OfferModel item;
  var imageFiles;
  var miniImageFiles;
  final Function onTap;
  final Function onTapMini;
  final String EAN;
  final String name;

  ItemDetailsList(
      {this.item,
      @required this.imageFiles,
      @required this.miniImageFiles,
      @required this.onTap,
      @required this.onTapMini,
      @required this.EAN,
      @required this.name});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          ListTile(
            onTap: onTap,
            hoverColor: Colors.grey.shade200,
            minVerticalPadding: 5,
            title: Text('Zdjęcia'),
            subtitle: Text('Dodaj'),
            leading: Icon(Icons.add_a_photo, color: Color(0xFF88D5E4)),
          ),
          Container(
            height: 500,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: imageFiles == null ? 1 : imageFiles.length,
                  itemBuilder: (contex, index) {
                    return imageFiles == null
                        ? Image.asset('assets/images/image_placeholder.jpg')
                        : Image.file(
                            new File(imageFiles.elementAt(index).path));
                  },
                ),
              ),
            ),
          ),
          ListTile(
            onTap: onTapMini,
            hoverColor: Colors.grey.shade200,
            minVerticalPadding: 5,
            title: Text('Zdjęcia miniaturki'),
            subtitle: Text('Dodaj'),
            leading: Icon(Icons.add_a_photo, color: Color(0xFF88D5E4)),
          ),
          Container(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: miniImageFiles == null ? 1 : miniImageFiles.length,
                  itemBuilder: (contex, index) {
                    return miniImageFiles == null
                        ? Image.asset('assets/images/image_placeholder.jpg')
                        : Image.file(
                            new File(miniImageFiles.elementAt(index).path));
                  },
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              'Tytuł oferty',
              style: TextStyle(color: Color(0xFF89ACBE)),
            ),
            subtitle: TextFormField(
              initialValue: name,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Dodaj tytuł'),
            ),
          ),
          ListTile(
            title: Text(
              'Opis',
              style: TextStyle(color: Color(0xFF89ACBE)),
            ),
            subtitle: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Dodaj opis'),
            ),
          ),
          ListTile(
            title: Text(
              'Kategoria produktu',
              style: TextStyle(color: Color(0xFF89ACBE)),
            ),
            subtitle: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Dodaj kategorię'),
            ),
          ),
          ListTile(
            title: Text(
              'Id oferty',
              style: TextStyle(color: Color(0xFF89ACBE)),
            ),
            subtitle: TextFormField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Dodaj Id'),
            ),
          ),
          ListTile(
            title: Text(
              'Nazwa produktu lub EAN',
              style: TextStyle(color: Color(0xFF89ACBE)),
            ),
            subtitle: TextFormField(
              initialValue: EAN,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'EAN'),
            ),
          ),
        ],
      ),
    );
  }
}
