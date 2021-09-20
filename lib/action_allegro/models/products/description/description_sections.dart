import 'description_sections_items_desc.dart';

class Section {
  List<Items_desc> items;

  Section({this.items});

  factory Section.fromJson(Map<String, dynamic> json) {
    var itemObject = json['items'] as List;
    List<Items_desc> _items = itemObject
        .map((items_desc) => Items_desc.fromJson(items_desc))
        .toList();
    return Section(
      items: _items,
    );
  }

  Map<String, dynamic> toJson() {
    return {'items': items};
  }
}
