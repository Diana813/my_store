class Items_desc {
  String type;
  String offer_description;

  Items_desc({this.offer_description, this.type});

  factory Items_desc.fromJson(Map<String, dynamic> json) {
    return Items_desc(type: json['type'], offer_description: json['content']);
  }
}
