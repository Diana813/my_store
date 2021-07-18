import 'package:my_store/action_allegro/models/categories/parent.dart';

import 'category_options.dart';

class Category {
  String id;
  bool leaf;
  String name;
  Options options;
  Parent parent;

  Category({this.id, this.leaf, this.name, this.options, this.parent});

  factory Category.fromJson(dynamic json) {
    var _parent = null;
    if (json['parent'] != null) {
      _parent = Parent.fromJson(json['parent']);
    }
    var _options = null;
    if (json['options'] != null) {
      _options = Options.fromJson(json['options']);
    }
    return Category(
      id: json['id'],
      leaf: json['leaf'],
      name: json['name'],
      options: _options,
      parent: _parent,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'leaf': leaf,
      'name': name,
      'options': options,
      'parent': parent
    };
  }
}
