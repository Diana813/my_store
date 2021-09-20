import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/products/images/photos.dart';

class ImageItem extends StatelessWidget {
  final List<Photo> imgList;
  final String filePath;

  ImageItem({this.imgList, this.filePath});

  _displayImages(List<Photo> imageFiles, int index) {
    if (!imageFiles.elementAt(index).url.contains('http')) {
      return Image.file(new File(imageFiles.elementAt(index).url),
          fit: BoxFit.contain);
    } else {
      return Image.network(imageFiles.elementAt(index).url, fit: BoxFit.contain);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
          child: Stack(
            children: <Widget>[
              _displayImages(imgList, imgList.indexWhere((element) => element.url == filePath)),
              Positioned(
                bottom: 0.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(200, 0, 0, 0),
                        Color.fromARGB(0, 0, 0, 0)
                      ],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                  child: Text(
                    'Zdjęcie nr ${imgList.indexWhere((element) => element.url == filePath) + 1}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
