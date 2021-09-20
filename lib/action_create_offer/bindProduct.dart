import 'package:my_store/action_allegro/models/products/products.dart';

import 'offer_model.dart';

class BindProduct {
  bool canCreateProduct = false;
  bool canBindWithProduct = false;
  bool bindWithProduct = true;
  bool productExist = false;
  bool checkBoxBindProductVisible = false;
  bool checkBoxBindingInfoVisible = false;
  String productQuestion = '';

  checkIfProductExist(var response) {
    if (response != null) {
      productExist = true;
    }
  }

  String askProductQuestion() {
    if (productExist) {
      return 'Powiąż z tym produktem';
    } else if (canCreateProduct) {
      return 'Utwórz nowy produkt';
    } else {
      return '';
    }
  }

  setProductId(Products productJson, OfferModel offer) {
    if (productJson == null) return;
    if (bindWithProduct) {
      offer.productId = productJson.products[0].id;
    } else {
      offer.productId = null;
    }
  }
}
