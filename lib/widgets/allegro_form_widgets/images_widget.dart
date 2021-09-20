import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/products/images/photos.dart';
import 'package:my_store/utils/colors.dart';
import 'package:my_store/widgets/image_item.dart';

class ImagesPart extends StatelessWidget {
  List<Photo> imageFiles;
  final Function onTap;
  final Function deletePhoto;
  var tapPosition;
  final CarouselController caruselController;
  final Function deleteAllPhotos;
  final String photosTitle;
  final String warning;
  final bool shouldWarn;

  ImagesPart({
    @required this.imageFiles,
    @required this.onTap,
    @required this.caruselController,
    @required this.deleteAllPhotos,
    @required this.deletePhoto,
    @required this.photosTitle,
    @required this.warning,
    @required this.shouldWarn,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          ListTile(
            onTap: onTap,
            hoverColor: Colors.grey.shade200,
            minVerticalPadding: 5,
            title: Text(photosTitle),
            subtitle: Text('Dodaj zdjęcia'),
            leading: Icon(Icons.add_a_photo, color: Color(0xFF88D5E4)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Visibility(
              child: Text(
                warning,
                style: TextStyle(color: Colors.red),
              ),
              visible: shouldWarn,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: OutlinedButton(
              onPressed: deleteAllPhotos,
              child: Text(
                'Usuń wszystkie zdjęcia',
                style: TextStyle(fontSize: 14),
              ),
            ),
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
                        itemCount: imageFiles.isEmpty ? 1 : imageFiles.length,
                        options: CarouselOptions(
                          enlargeCenterPage: true,
                          viewportFraction: 0.6,
                          aspectRatio: 21 / 9,
                        ),
                        itemBuilder: (context, index, realIdx) {
                          return imageFiles.isEmpty
                              ? Image.asset(
                                  'assets/images/image_placeholder.jpg')
                              : GestureDetector(
                                  onSecondaryTapDown:
                                      (TapDownDetails tapDownDetails) {
                                    tapPosition = tapDownDetails.globalPosition;
                                  },
                                  onSecondaryTap: () {
                                    deletePhoto(index, context, tapPosition);
                                  },
                                  child: ImageItem(
                                    filePath: imageFiles.elementAt(index).url,
                                    imgList: imageFiles,
                                  ),
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
        ]);
  }
}
