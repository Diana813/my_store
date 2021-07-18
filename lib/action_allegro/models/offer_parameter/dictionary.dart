import 'package:my_store/action_allegro/models/offer_parameter/dictionary_item.dart';

class Dictionary {
  List<DictionaryItem> dictionary;

  Dictionary({this.dictionary});

  factory Dictionary.fromJson(dynamic json) {
    if (json['dictionary'] != null) {
      var objsJson = json['dictionary'] as List;
      List<DictionaryItem> _dictionary =
          objsJson.map((tagJson) => DictionaryItem.fromJson(tagJson)).toList();

      return Dictionary(dictionary: _dictionary);
    } else
      return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'dictionary': dictionary,
    };
  }
}
