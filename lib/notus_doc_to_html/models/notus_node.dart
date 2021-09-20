import 'attributes.dart';

class NotusNode {
  String insert = '';
  Attributes attributes = Attributes();

  NotusNode({this.insert, this.attributes});

  factory NotusNode.fromJson(dynamic json) {
    var _attributes = null;
    if (json['attributes'] != null) {
      _attributes = Attributes.fromJson(json['attributes']);
    }
    return NotusNode(
      insert: json['insert'],
      attributes: _attributes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'insert': insert,
      'attributes': attributes,
    };
  }
}
