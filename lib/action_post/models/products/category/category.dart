import 'package:my_store/action_post/models/products/category/similar.dart';

class ProductCategory {
  String id;
  List<Similar> similars;

  ProductCategory({this.id, this.similars});

  factory ProductCategory.fromJson(Map<String, dynamic> json) {
    var similarObject = json['similar'] as List;
    List<Similar> _similars =
        similarObject.map((id) => Similar.fromJson(id)).toList();
    return ProductCategory(
      id: json['id'] as String,
      similars: _similars,
    );
  }
}
