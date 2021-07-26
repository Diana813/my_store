import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/allegro_api/post/post_offer.dart';
import 'package:my_store/action_allegro/models/products/images/photos.dart';
import 'package:my_store/action_allegro/models/products/products.dart';
import 'package:my_store/action_allegro/product/product_model.dart';
import 'package:my_store/action_mysql/my_offers_table.dart';

class OfferImages {
  bool shouldWarn = false;
  List<String> photos = [];
  List<String> photosFromDb = [];
  String photosTitle = '';

  List<String> getPhotosFromAllegro(Products productJson) {
    List<String> imagesFiles = [];
    if (productJson != null && productJson.offers[0].photos.length != 0) {
      for (int i = 0; i < productJson.offers[0].photos.length; i++) {
        imagesFiles.add(productJson.offers[0].photos[i].url);
      }
    }
    return imagesFiles;
  }

  addOwnPhotosToTheList(List<String> files, List<String> photos) {
    if (photos == null) {
      photos = [];
    }
    photos.addAll(files);
    return photos;
  }

  deleteListOfPhotos(List<String> imagesFiles, String EAN) async {
    imagesFiles.clear();
    photosTitle = displayPhotosTitle(null, photos, photosFromDb);
    return imagesFiles;
  }

  deletePhoto(int index, List<String> imagesFiles, String EAN,
      Products products) async {
    imagesFiles.removeAt(index);
    photosTitle = displayPhotosTitle(null, photos, photosFromDb);
    return imagesFiles;
  }

  displayPhotosTitle(Products productJson, List<String> imagesFiles,
      List<dynamic> allegroImagesFromDb) {
    List<String> imagesFromAllegro = getPhotosFromAllegro(productJson);
    if (imagesFiles.isNotEmpty || allegroImagesFromDb.isNotEmpty) {
      return 'Twoje zdjęcia';
    } else if (imagesFromAllegro.isNotEmpty) {
      return 'Zdjęcia z Allegro';
    } else {
      return 'Nie dodałeś jeszcze żadnych zdjęć';
    }
  }

  addPhotosToDb(List<String> photos, String EAN) async {
    List<String> myAllegroUrls = await downloadUrlsFromAllegro(photos);
    String allegroUrls = '';
    for (int i = 0; i < myAllegroUrls.length; i++) {
      if (i < myAllegroUrls.length - 1) {
        allegroUrls = allegroUrls + myAllegroUrls.elementAt(i) + ', ';
      } else {
        allegroUrls = allegroUrls + myAllegroUrls.elementAt(i);
      }
    }
    MyOffersTable.addPhotoURLs(allegroUrls, EAN);
  }

  downloadUrlsFromAllegro(List<String> photos) async {
    List<String> imageUrls = [];
    for (String photo in photos) {
      if (photo.contains('allegroimg')) {
        imageUrls.add(photo);
        continue;
      }
      await PostOffer.addImegesToAllegroServer(photo, imageUrls);
    }
    return imageUrls;
  }

  setMyOfferImages() async {
    List<Photo> myPhotos = [];
    List<dynamic> images = await downloadUrlsFromAllegro(photos);

    for (int i = 0; i < images.length; i++) {
      Photo photo = new Photo();
      photo.url = images.elementAt(i);
      myPhotos.add(photo);
    }
    return myPhotos;
  }

  static getPhotosFromDb(String EAN) async {
    String urls = '';
    List<String> photos = [];
    var result = await MyOffersTable.getPhotosURLs(EAN);
    if (result.toString() != "()") {
      print(result.toString());
      urls = result.first[0].toString();
      if (urls != '') {
        photos.addAll(urls.split(', '));
      }
    }
    return photos;
  }

  static copyPaste() {}

  List<String> displayAllPhotos(Products productJson, List<String> imagesFiles,
      List<String> allegroImagesFromDb) {
    List<String> imagesFromAllegro = getPhotosFromAllegro(productJson);
    if (allegroImagesFromDb.isNotEmpty) {
      return allegroImagesFromDb;
    } else if (imagesFiles.isNotEmpty) {
      return imagesFiles;
    } else if (imagesFromAllegro.isNotEmpty) {
      return imagesFromAllegro;
    } else {
      return [];
    }
  }

  imageListLimitWarning(List<String> photos) {
    if (photos.length > 16) {
      shouldWarn = true;
      return 'Możesz dodać maksymalnie 16 zdjęć. Usuń ' +
          (photos.length - 16).toString() +
          ' zdjęć.';
    } else {
      return '';
    }
  }

  showPopupMenuToDeletePhoto(BuildContext context, var tapPosition, String EAN,
      ProductModel productModel, int index, Function updateState) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
          tapPosition & const Size(40, 40), Offset.zero & overlay.size),
      items: [
        PopupMenuItem<String>(child: const Text('Usuń'), value: '1'),
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) async {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        photos = await deletePhoto(index, photos, EAN, productModel.products);
        imageListLimitWarning(photos);
        print('Usuwam zdjęcie');
        print(photos.length);
        updateState();
      }
    });
  }
}
