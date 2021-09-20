class RangeValue {
  String from;
  String to;


  RangeValue({this.from, this.to});

  factory RangeValue.fromJson(dynamic json) {
    return RangeValue(
      from: json['from'],
      to: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}
