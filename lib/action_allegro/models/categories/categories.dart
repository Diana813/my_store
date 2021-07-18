import 'package:my_store/action_allegro/models/categories/category.dart';

class Categories {
  List<Category> categories;

  Categories({this.categories});

  factory Categories.fromJson(dynamic json) {
    if (json['categories'] != null) {
      var objsJson = json['categories'] as List;
      List<Category> _categories =
          objsJson.map((tagJson) => Category.fromJson(tagJson)).toList();

      return Categories(categories: _categories);
    } else
      return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'categories': categories,
    };
  }
}
