import 'package:my_store/action_allegro/models/categories/category.dart';
import 'package:my_store/action_allegro/models/products/category/category.dart';
import 'package:my_store/action_allegro/models/products/description/description.dart';
import 'package:my_store/action_allegro/models/products/description/description_sections.dart';
import 'package:my_store/action_allegro/models/products/description/description_sections_items_desc.dart';
import 'package:my_store/action_allegro/models/products/images/photos.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';
import 'package:my_store/action_create_offer/models/stock.dart';

import 'models/pricing/price.dart';
import 'models/pricing/selling_mode.dart';

class OfferModel {
  String title;
  Category category;
  ProductCategory productCategory;
  List<ParameterToPost> parameters;
  List<Photo> images = [];
  Description description = Description(sections: [
    Section(items: [
      Items_desc(
          type: 'TEXT',
          offer_description:
              '<h2>Szanowni Państwo</h2><h1>- PROSIMY DOKŁADNIE CZYTAĆ OPIS!</h1><p>Poniżej prezentujemy jak najbardziej obiektywny opis przedmiotu:</p>')
    ]),
    Section(items: [
      Items_desc(
          type: 'TEXT',
          offer_description:
              '<h1>WADY:</h1><ul><li><b>Podniszczone oryginalne opakowanie</b></li></ul>')
    ]),
    Section(items: [
      Items_desc(
          type: 'TEXT',
          offer_description:
              '<h1>Zalety:</h1><ul><li><b>Niska cena</b></li></ul>')
    ]),
    Section(items: [
      Items_desc(
          type: 'TEXT', offer_description: '<p><b>OPIS PRODUCENTA</b></p>')
    ]),
    Section(items: [
      Items_desc(
          type: 'TEXT',
          offer_description:
              '<p>Każdą rzecz przed wystawieniem sprawdzamy i rzetelnie opisujemy jej wady . Mimo usilnych starań może się zdarzyć, że coś przeoczymy. Proszę wziąć pod uwagę, że jesteśmy tylko ludźmi i popełniamy błędy.</p><p>BRAK INSTRUKCJI W JĘZYKU POLSKIM</p>')
    ])
  ]);
  String productId;
  SellingMode sellingMode = SellingMode(
      price: Price(amount: '0', currency: 'PLN'),
      minimalPrice: Price(amount: '0', currency: 'PLN'),
      startingPrice: Price(amount: '0', currency: 'PLN'),
      netPrice: Price(amount: '0', currency: 'PLN'));
  Stock stock = Stock();
}
