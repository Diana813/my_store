import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_post/models/products/offer.dart';
import 'package:my_store/action_post/models/products/parameters/parameter.dart';
import 'package:my_store/utlis/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:my_store/widgets/image_item.dart';
import 'package:my_store/widgets/parameters_list.dart';

class ItemDetailsList extends StatelessWidget {
  final OfferModel item;
  var imageFiles;
  var miniImageFiles;
  final Function onTap;
  final Function onTapMini;
  final String EAN;
  String name;
  String description;
  List<Parameter> parameters;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final TextEditingController categoryController;
  var iconButtonColor = Color(ColorsMyStore.AccentColor);
  final CarouselController caruselController;

  ItemDetailsList(
      {this.item,
      @required this.imageFiles,
      @required this.miniImageFiles,
      @required this.onTap,
      @required this.onTapMini,
      @required this.EAN,
      @required this.name,
      @required this.description,
      @required this.parameters,
      @required this.nameController,
      @required this.descriptionController,
      @required this.categoryController,
      @required this.caruselController});

  getColor() {
    iconButtonColor = Color(ColorsMyStore.PrimaryColor);
  }

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
            child: Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      CarouselSlider.builder(
                        carouselController: caruselController,
                        itemCount: imageFiles == null ? 1 : imageFiles.length,
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          viewportFraction: 0.6,
                          aspectRatio: 21 / 9,
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return imageFiles == null
                              ? Image.asset(
                                  'assets/images/image_placeholder.jpg')
                              : ImageItem(
                                  filePath: imageFiles.elementAt(index),
                                  imgList: imageFiles,
                                );
                        },
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                    color: Color(ColorsMyStore.AccentColor),
                                    iconSize: 50,
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                    ),
                                    onPressed: () =>
                                        caruselController.previousPage()),
                                IconButton(
                                  color: Color(ColorsMyStore.AccentColor),
                                  iconSize: 50,
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                  ),
                                  onPressed: () => caruselController.nextPage(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
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
                        : Image.file(new File(miniImageFiles.elementAt(index)));
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
              controller: nameController,
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
              controller: descriptionController,
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
              controller: categoryController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                  border: UnderlineInputBorder(), labelText: 'Dodaj kategorię'),
            ),
          ),
          ListTile(
            title: Text(
              'Parametry',
              style: TextStyle(color: Color(0xFF89ACBE)),
            ),
            subtitle: ParametersList(
              parameters: parameters,
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
