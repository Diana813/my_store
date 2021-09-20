import 'package:my_store/action_allegro/models/products/product.dart';

class Products {
  List<Product> products;

  Products(this.products);

  factory Products.fromJson(dynamic json) {
    if (json['products'] != null) {
      var objsJson = json['products'] as List;
      List<Product> _products =
          objsJson.map((tagJson) => Product.fromJson(tagJson)).toList();

      return Products(
        _products,
      );
    }
    else return null;
  }
}
