import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:html/parser.dart';
import 'package:my_store/action_allegro/allegro_api/get/get_product_data.dart';
import 'package:my_store/action_allegro/models/categories/category.dart';
import 'package:my_store/action_allegro/models/products/description/description_sections_items_desc.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/action_allegro/models/products/products.dart';
import 'package:my_store/action_create_offer/bindProduct.dart';
import 'package:my_store/action_create_offer/offer_param.dart';
import 'package:my_store/action_create_offer/offer_categories.dart';
import 'package:my_store/action_create_offer/offer_images.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/action_find_item_on_the_internet/network_search_brain.dart';

class ProductModel {
  Products products;

  Future<Products> getProductByEan(String EAN) async {
    final response = await NetworkHelper.getProductData(EAN.split('.')[0]);
    if (response != null) {
      Products product = Products.fromJson(response);
      if (product != null && product.offers != null && product.offers != []) {
        if (product.offers.length != 0) {
          return product;
        }
      }
    }
    return null;
  }

  String getName(String productName) {
    String name = productName;
    return NetworkSearchBrain.findCeneoString(name);
  }

  String getProductTitle(Products product, String productName) {
    if (product != null) {
      return product.offers[0].offerTitle;
    } else {
      return getName(productName);
    }
  }

  String getProductDescription(Products productJson) {
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

  List<Parameter> getParameters(Products productJson) {
    if (productJson != null) {
      return productJson.offers[0].parameters;
    }
    return [];
  }

  getCategory(Products productJson) {
    if (productJson != null) {
      return productJson.offers[0].category;
    }
  }

  String getCategoryId(Products productJson) {
    if (productJson != null) {
      return productJson.offers[0].category.id;
    }
    return '';
  }

  Future<String> getCategoryName(Products productJson) async {
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
      return '';
    }
    return '';
  }

  getProduct(
      String EAN,
      OfferCategories offerCategories,
      OfferModel myOffer,
      String description,
      TextEditingController nameController,
      String productName,
      TextEditingController descriptionController,
      OfferParam offerParam,
      OfferImages offerImages,
      List<String> imagesFiles,
      BindProduct bindProduct,
      Function updateProductData) async {
    EasyLoading.show();
    products = await getProductByEan(EAN);
    offerCategories.categoryName = await getCategoryName(products);
    myOffer.productCategory = getCategory(products);
    EasyLoading.dismiss();
    updateProductData();
  }

  setProductData(
      OfferCategories offerCategories,
      OfferParam offerParam,
      OfferImages offerImages,
      List<String> imagesFiles,
      BindProduct bindProduct) {
    if (products == null) {
      offerCategories.categoryName = '';
    }
    offerParam.productParameters = getParameters(products);
    offerImages.photosTitle = offerImages.displayPhotosTitle(
        products, imagesFiles, offerImages.photosFromDb);
    offerImages.photos = offerImages.displayAllPhotos(
        products, imagesFiles, offerImages.photosFromDb);
    bindProduct.checkIfProductExist(products);
    if (bindProduct.productExist) {
      bindProduct.checkBoxBindProductVisible = true;
      offerCategories.allowChangingCategory = false;
    }
    bindProduct.productQuestion = bindProduct.askProductQuestion();
  }

  String getDescription() {
    return getProductDescription(products);
  }

  TextEditingController getNameController(String productName) {
    return TextEditingController(text: getProductTitle(products, productName));
  }

  TextEditingController getDescriptionController(String description) {
    return TextEditingController(text: description);
  }
}
