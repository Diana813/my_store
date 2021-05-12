import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  final List<String> imgList;
  final String filePath;

  ImageItem({this.imgList, this.filePath});

  _displayImages(var imageFiles, int index) {
    if(!imageFiles.elementAt(index).contains('http')){
      return Image.file(new File(imageFiles.elementAt(index)),
          fit: BoxFit.contain);
    } else {
      return Image.network(imageFiles.elementAt(index), fit: BoxFit.contain);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            child: Stack(
              children: <Widget>[
                _displayImages(imgList, imgList.indexOf(filePath)),
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
                      'Zdjęcie nr ${imgList.indexOf(filePath) + 1}',
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
      ),
    );
  }
}
