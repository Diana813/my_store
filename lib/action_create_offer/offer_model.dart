import 'package:my_store/action_allegro/models/categories/category.dart';
import 'package:my_store/action_allegro/models/products/category/category.dart';
import 'package:my_store/action_allegro/models/products/images/photos.dart';
import 'package:my_store/action_create_offer/models/parameter.dart';

import 'offer_description.dart';


class OfferModel {
  String title;
  Category category;
  ProductCategory productCategory;
  List<MyParameter> parameters;
  List<Photo> images = [];
  OfferDescription description;
  String productId;
}
