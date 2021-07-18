class Similar {
  String id;

  Similar({this.id});

  Similar.fromJson(Map<String, dynamic> json) : id = json['id'] as String;

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
