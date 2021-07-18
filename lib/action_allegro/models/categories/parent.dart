class Parent {
  String id;

  Parent({this.id});

  factory Parent.fromJson(Map<String, dynamic> json) {
    return Parent(id: json['id']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id};
  }
}
