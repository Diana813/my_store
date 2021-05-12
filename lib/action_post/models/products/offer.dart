import 'package:my_store/action_post/models/products/category/category.dart';
import 'package:my_store/action_post/models/products/description/description.dart';
import 'package:my_store/action_post/models/products/images/photos.dart';
import 'package:my_store/action_post/models/products/parameters/parameter.dart';

class OfferModel {
  List<Photos> photos;
  var offerTitle;
  Description offerDescription;
  List<Parameter> parameters;
  ProductCategory category;

  /*String productNameOrEan;
  String offerId;*/

  OfferModel(this.photos, this.offerTitle, this.offerDescription,
      this.parameters, this.category
      /*this.productNameOrEan,
      this.parameters,
      this.offerId*/
      );

  factory OfferModel.fromJson(dynamic json) {
    return OfferModel(
      _getPhotos(json),
      json['name'] as String,
      _getDescription(json),
      _getParameters(json),
      _getCategory(json),
    );
  }
}

_getPhotos(dynamic json) {
  if (json['images'] != null) {
    var imageObjsJson = json['images'] as List;
    return imageObjsJson.map((url) => Photos.fromJson(url)).toList();
  } else {
    return [];
  }
}

_getDescription(dynamic json) {
  if (json['description'] != null) {
    return Description.fromJson(json['description']);
  } else {
    return null;
  }
}

_getParameters(dynamic json) {
  if (json['parameters'] != null) {
    var imageObjsJson = json['parameters'] as List;
    return imageObjsJson
        .map((parameter) => Parameter.fromJson(parameter))
        .toList();
  } else {
    return [];
  }
}

_getCategory(dynamic json) {
  if (json['category'] != null) {
    return ProductCategory.fromJson(json['category']);
  }
}
