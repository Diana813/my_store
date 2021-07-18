import 'description_sections_items_desc.dart';

class Sections {
  List<Items_desc> items;

  Sections({this.items});

  factory Sections.fromJson(Map<String, dynamic> json) {
    var itemObject = json['items'] as List;
    List<Items_desc> _items = itemObject
        .map((items_desc) => Items_desc.fromJson(items_desc))
        .toList();
    return Sections(
      items: _items,
    );
  }
}
