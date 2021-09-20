import 'package:my_store/action_create_offer/models/range.dart';

class Parameter {
  String id;
  String name;
  List<dynamic> values_label;
  List<dynamic> valuesIds;
  List<dynamic> values;
  RangeValue rangeValue;

  Parameter({this.id, this.name, this.values_label, this.valuesIds, this.values, this.rangeValue});

  factory Parameter.fromJson(dynamic json) {
    var _valuesLabels = json['valuesLabels'] as List;
    var _valuesIds = json['valuesIds'] as List;
    var _values = json['values'] as List;
    var _rangeValue = null;
    if (json['rangeValue'] != null) {
      _rangeValue = RangeValue.fromJson(json['rangeValue']);
    }

    return Parameter(
      id: json['id'],
      name: json['name'],
      values_label: _valuesLabels,
      valuesIds: _valuesIds,
      values: _values,
      rangeValue: _rangeValue,
    );
  }
}
