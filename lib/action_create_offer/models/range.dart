class RangeValue {
  String from;
  String to;


  RangeValue({this.from, this.to});

  Map<String, dynamic> toJson() {
    return {
      'from': from,
      'to': to,
    };
  }
}
