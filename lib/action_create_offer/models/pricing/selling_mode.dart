import 'package:my_store/action_create_offer/models/pricing/price.dart';

class SellingMode {
  String format;
  Price price;
  Price minimalPrice;
  Price startingPrice;
  Price netPrice;

  SellingMode(
      {this.format,
      this.price,
      this.minimalPrice,
      this.startingPrice,
      this.netPrice});

  factory SellingMode.fromJson(dynamic json) {
    var _price = null;
    if (json['price'] != null) {
      _price = Price.fromJson(json['price']);
    }
    var _minimalPrice = null;
    if (json['price'] != null) {
      _minimalPrice = Price.fromJson(json['minimalPrice']);
    }
    var _startingPrice = null;
    if (json['price'] != null) {
      _startingPrice = Price.fromJson(json['startingPrice']);
    }
    var _netPrice = null;
    if (json['price'] != null) {
      _netPrice = Price.fromJson(json['netPrice']);
    }

    return SellingMode(
      format: json['format'],
      price: _price,
      minimalPrice: _minimalPrice,
      startingPrice: _startingPrice,
      netPrice: _netPrice,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'format': format,
      'price': price,
      'minimalPrice': minimalPrice,
      'startingPrice': startingPrice,
      'netPrice': netPrice,
    };
  }
}
