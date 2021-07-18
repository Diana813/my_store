class Photo {
  String url;

  Photo({this.url});

  Photo.fromJson(Map<String, dynamic> json) : url = json['url'];

  Map<String, dynamic> toJson() {
    return {
      'url': url,
    };
  }

}
