import 'package:my_store/action_post/models/categories/parent.dart';

class Category {
  String id;
  bool leaf;
  String name;
  var options;
  Parent parent;

  Category({this.id, this.leaf, this.name, this.options, this.parent});

  factory Category.fromJson(dynamic json) {
    var _parent = null;
    if (json['parent'] != null) {
      _parent = Parent.fromJson(json['parent']);
    }
    return Category(
      id: json['id'],
      leaf: json['leaf'],
      name: json['name'],
      options: json['options'],
      parent: _parent,
    );
  }
}
