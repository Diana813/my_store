class DictionaryItem {
  String id;
  String value;
  List<dynamic> dependsOnValueIds;

  DictionaryItem({this.id, this.value, this.dependsOnValueIds});

  factory DictionaryItem.fromJson(dynamic json) {
    return DictionaryItem(
      id: json['id'] as String,
      value: json['value'] as String,
      dependsOnValueIds: json['dependsOnValueIds'] as List,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'value': value,
      'dependsOnValueIds': dependsOnValueIds,
    };
  }
}
