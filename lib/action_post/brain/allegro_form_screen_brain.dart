import 'package:html/parser.dart';
import 'package:my_store/action_find_item_on_the_internet/network_search_brain.dart';
import 'package:my_store/action_post/allegro_api/networking.dart';
import 'package:my_store/action_post/models/categories/category.dart';
import 'package:my_store/action_post/models/products/description/description_sections_items_desc.dart';
import 'package:my_store/action_post/models/products/parameters/parameter.dart';
import 'package:my_store/action_post/models/products/product.dart';

class AllegroBrain {
  static String getName(String productName) {
    String name = productName;
    return NetworkSearchBrain.findCeneoString(name);
  }

  static Future<ProductJson> getProductByEan(String EAN) async {
    final response = await NetworkHelper.getProductData(EAN.split('.')[0]);
    if (response != null) {
      ProductJson product = ProductJson.fromJson(response);
      if (product != null && product.offers != null && product.offers != []) {
        if (product.offers.length != 0) {
          return product;
        }
      }
    }
  }

  static String getProductDescription(ProductJson productJson) {
    if (productJson != null) {
      if (productJson.offers[0].offerDescription == null) {
        return null;
      }
      List<Items_desc> items =
          productJson.offers[0].offerDescription.sections[0].items;
      String description;
      for (Items_desc item in items) {
        if (item.type == 'TEXT') {
          description = parse(item.offer_description).documentElement.text;
          break;
        }
        description = null;
      }
      return description;
    } else {
      return null;
    }
  }

  static String getProductTitle(ProductJson productJson, String productName) {
    if (productJson != null) {
      return productJson.offers[0].offerTitle;
    } else {
      return getName(productName);
    }
  }

  static getPhotoUrls(ProductJson productJson, List<String> imagesFiles) {
    if (productJson != null && productJson.offers[0].photos.length != 0) {
      if (imagesFiles == null) {
        imagesFiles = [];
      }
      for (int i = 0; i < productJson.offers[0].photos.length; i++) {
        imagesFiles.add(productJson.offers[0].photos[i].url);
      }
      return imagesFiles;
    } else {
      return null;
    }
  }

  static List<Parameter> getParameters(ProductJson productJson) {
    if (productJson != null) {
      return productJson.offers[0].parameters;
    }
  }

  static String getCategoryId(ProductJson productJson) {
    if (productJson != null) {
      return productJson.offers[0].category.id;
    }
  }

  static Future<String> getCategoryName(ProductJson productJson) async {
    String categoryId = getCategoryId(productJson);
    var response = await NetworkHelper.getCategoryById(categoryId);
    if (response != null) {
      Category category = Category.fromJson(response);
      if (category != null) {
        String categoryName = category.name;
        while (category.parent != null) {
          var response =
              await NetworkHelper.getCategoryById(category.parent.id);
          category = Category.fromJson(response);
          if (category != null) {
            categoryName = category.name + ' -> ' + categoryName;
          }
        }
        return categoryName;
      }
    }
  }
}
