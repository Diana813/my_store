class Stock {
  int available;
  String unit;

  Stock({this.available, this.unit});

  factory Stock.fromJson(dynamic json) {
    return Stock(
      available: json['available'],
      unit: json['unit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'available': available,
      'unit': unit,
    };
  }
}
