import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/allegro_api/post/post_offer.dart';
import 'package:my_store/action_allegro/models/products/images/photos.dart';
import 'package:my_store/action_allegro/models/products/products.dart';
import 'package:my_store/action_allegro/product/product_model.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/action_mysql/my_offers_table.dart';

class OfferImages {
  bool shouldWarn = false;
  List<String> photosFromDb = [];
  String photosTitle = '';
  bool cannotDelete = false;

  List<String> getPhotosFromAllegro(Products productJson) {
    List<String> imagesFiles = [];
    if (productJson != null && productJson.products[0].photos.length != 0) {
      for (int i = 0; i < productJson.products[0].photos.length; i++) {
        imagesFiles.add(productJson.products[0].photos[i].url);
      }
    }
    return imagesFiles;
  }

  addOwnPhotosToTheList(List<String> files) {
    List<String> photos = [];
    if (photos == null) {
      photos = [];
    }
    photos.addAll(files);
    return photos;
  }

  deleteListOfPhotos(List<Photo> imagesFiles, String EAN, Products productJson,
      OfferModel myOffer) async {
    List<Photo> usedPhotos = [];
    for (int i = 0; i < imagesFiles.length; i++) {
      if (photoIsUsedInProductDescription(imagesFiles, i, productJson)) {
        usedPhotos.add(imagesFiles[i]);
      }
    }
    imagesFiles.clear();
    imagesFiles.addAll(usedPhotos);
    photosTitle = displayPhotosTitle(null, myOffer.images, photosFromDb);
    return imagesFiles;
  }

  deletePhoto(int index, List<Photo> imagesFiles, String EAN,
      OfferModel myOffer) async {
    imagesFiles.removeAt(index);
    photosTitle = displayPhotosTitle(null, myOffer.images, photosFromDb);
    return imagesFiles;
  }

  photoIsUsedInProductDescription(
      List<Photo> imagesFiles, int index, Products productJson) {
    if (productJson != null &&
        productJson.products[0].offerDescription != null) {
      for (int i = 0;
          i < productJson.products[0].offerDescription.sections.length;
          i++) {
        for (int j = 0;
            j <
                productJson
                    .products[0].offerDescription.sections[i].items.length;
            j++)
          if (productJson
                  .products[0].offerDescription.sections[i].items[j].url ==
              imagesFiles[index].url) return true;
      }
    }
    return false;
  }

  displayPhotosTitle(Products productJson, List<Photo> imagesFiles,
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

  setMyOfferImages(List<String> photos) async {
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

  Future<List<Photo>> displayAllPhotos(Products productJson, OfferModel offerModel) async {
    List<String> imagesFromAllegro = getPhotosFromAllegro(productJson);
    if (photosFromDb.isNotEmpty) {
      return await setMyOfferImages(photosFromDb);
    } else if (imagesFromAllegro.isNotEmpty) {
      return await setMyOfferImages(imagesFromAllegro);
    } else if (offerModel.images.isNotEmpty) {
      return offerModel.images;
    } else {
      return [];
    }
  }

  imageListLimitWarning(List<Photo> photos) {
    if (photos.length > 16) {
      shouldWarn = true;
      return 'Możesz dodać maksymalnie 16 zdjęć. Usuń ' +
          (photos.length - 16).toString() +
          '.';
    } else {
      return '';
    }
  }

  showPopupMenuToDeletePhoto(
      BuildContext context,
      var tapPosition,
      String EAN,
      ProductModel productModel,
      int index,
      Function updateState,
      OfferModel myOffer) {
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    showMenu<String>(
      context: context,
      position: RelativeRect.fromRect(
          tapPosition & const Size(40, 40), Offset.zero & overlay.size),
      items: [
        PopupMenuItem<String>(
            child: photoIsUsedInProductDescription(
                    myOffer.images, index, productModel.products)
                ? Text('Usuń',
                    style: TextStyle(decoration: TextDecoration.lineThrough))
                : Text('Usuń'),
            value: '1'),
      ],
      elevation: 8.0,
    ).then<void>((String itemSelected) async {
      if (itemSelected == null) return;

      if (itemSelected == "1") {
        if (photoIsUsedInProductDescription(
                myOffer.images, index, productModel.products) ==
            false) {
          myOffer.images =
              await deletePhoto(index, myOffer.images, EAN, myOffer);
          imageListLimitWarning(myOffer.images);
          updateState();
        }
      }
    });
  }
}
