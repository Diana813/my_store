class Photos {
  String url;

  Photos({this.url});

  Photos.fromJson(Map<String, dynamic> json) : url = json['url'];
}
