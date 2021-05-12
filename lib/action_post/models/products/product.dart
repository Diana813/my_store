import 'package:my_store/action_post/models/products/offer.dart';

class ProductJson {
  List<OfferModel> offers;

  ProductJson(this.offers);

  factory ProductJson.fromJson(dynamic json) {
    if (json['products'] != null) {
      var objsJson = json['products'] as List;
      List<OfferModel> _offers =
          objsJson.map((tagJson) => OfferModel.fromJson(tagJson)).toList();

      return ProductJson(
        _offers,
      );
    }
    else return null;
  }
}
