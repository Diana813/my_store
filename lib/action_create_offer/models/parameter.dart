import 'package:my_store/action_create_offer/models/range.dart';

class MyParameter {
  String id;
  List<String> valuesIds;
  List<String> values;
  RangeValue rangeValue;


  MyParameter({this.id, this.valuesIds, this.values, this.rangeValue});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'valuesIds': valuesIds,
      'values': values,
      'rangeValue': rangeValue,
    };
  }
}
