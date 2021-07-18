import 'package:my_store/action_allegro/models/offer_parameter/dictionary_item.dart';

import 'options.dart';
import 'restrictions.dart';

class OfferParameter {
  String id;
  String name;
  String type;
  bool required;
  bool requiredForProduct;
  ParameterOptions options;
  Restrictions restrictions;
  List<DictionaryItem> dictionary;


  OfferParameter(
      {this.id,
      this.name,
      this.type,
      this.required,
      this.requiredForProduct,
      this.options,
      this.restrictions,
      this.dictionary});

  factory OfferParameter.fromJson(dynamic json) {
    var _options = null;
    if (json['options'] != null) {
      _options = ParameterOptions.fromJson(json['options']);
    }

    var _restrictions = null;
    if (json['restrictions'] != null) {
      _restrictions = Restrictions.fromJson(json['restrictions']);
    }

    var objsJson = json['dictionary'] as List;
    List<DictionaryItem> _dictionary = [];
    if (objsJson != null) {
      _dictionary =
          objsJson.map((tagJson) => DictionaryItem.fromJson(tagJson)).toList();
    }

    return OfferParameter(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      required: json['required'],
      requiredForProduct: json['requiredForProduct'],
      options: _options,
      restrictions: _restrictions,
      dictionary: _dictionary,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'required': required,
      'requiredForProduct': requiredForProduct,
      'options': options,
      'restrictions': restrictions,
      'dictionary': dictionary,
    };
  }
}
