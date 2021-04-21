import 'package:my_store/action_post/models/payment.dart';

import 'delivery.dart';

class OfferModel {
  List<String> photos;
  String offerTitle;
  String offerDescription;
  String productNameOrEan;
  String productCategory;
  List<String> parameters;
  String offerId;
  Delivery delivery;
  Payment payment;

  OfferModel(
      {this.photos,
      this.offerTitle,
      this.offerDescription,
      this.productNameOrEan,
      this.productCategory,
      this.parameters,
      this.offerId,
      this.delivery,
      this.payment});
}
