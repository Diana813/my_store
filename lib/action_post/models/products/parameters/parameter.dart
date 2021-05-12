class Parameter {
  String name;
  List<dynamic> values_label;

  Parameter({this.name, this.values_label});

  factory Parameter.fromJson(dynamic json) {
    var _values = json['valuesLabels'] as List;
    return Parameter(
      name: json['name'],
      values_label: _values,
    );
  }
}
