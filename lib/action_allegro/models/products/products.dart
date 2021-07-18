import 'package:my_store/action_allegro/models/products/product.dart';

class Products {
  List<Product> offers;

  Products(this.offers);

  factory Products.fromJson(dynamic json) {
    if (json['products'] != null) {
      var objsJson = json['products'] as List;
      List<Product> _offers =
          objsJson.map((tagJson) => Product.fromJson(tagJson)).toList();

      return Products(
        _offers,
      );
    }
    else return null;
  }
}
