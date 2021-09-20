class Items_desc {
  String type;
  String offer_description;
  String url;

  Items_desc({this.offer_description, this.type, this.url});

  factory Items_desc.fromJson(Map<String, dynamic> json) {
    return Items_desc(
        type: json['type'],
        offer_description: json['content'],
        url: json['url']);
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'content': offer_description, 'url': url};
  }
}
