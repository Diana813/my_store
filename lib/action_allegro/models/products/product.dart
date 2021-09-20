import 'package:my_store/action_allegro/models/products/category/category.dart';
import 'package:my_store/action_allegro/models/products/description/description.dart';
import 'package:my_store/action_allegro/models/products/images/photos.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';

class Product {
  List<Photo> photos;
  var offerTitle;
  String id;
  Description offerDescription;
  List<Parameter> parameters;
  ProductCategory category;

  Product(this.photos, this.offerTitle, this.id, this.offerDescription,
      this.parameters, this.category);

  factory Product.fromJson(dynamic json) {
    return Product(
      _getPhotos(json),
      json['name'] as String,
      json['id'] as String,
      _getDescription(json),
      _getParameters(json),
      _getCategory(json),
    );
  }
}

_getPhotos(dynamic json) {
  if (json['images'] != null) {
    var imageObjsJson = json['images'] as List;
    return imageObjsJson.map((url) => Photo.fromJson(url)).toList();
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
