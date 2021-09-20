class Attributes {
  int heading = 0;
  String block = '';
  bool b = false;

  /* NotusAttribute.italic
  NotusAttribute.link*/

  Attributes({this.heading, this.block, this.b});

  factory Attributes.fromJson(dynamic json) {
    return Attributes(
      heading: json['heading'],
      block: json['block'],
      b: json['b'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'heading': heading,
      'block': block,
      'b': b,
    };
  }
}
