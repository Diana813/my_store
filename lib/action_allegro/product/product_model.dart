import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/action_allegro/allegro_api/get/get_product_data.dart';
import 'package:my_store/action_allegro/models/categories/category.dart';
import 'package:my_store/action_allegro/models/products/category/similar.dart';
import 'package:my_store/action_allegro/models/products/description/description.dart';
import 'package:my_store/action_allegro/models/products/images/photos.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/action_allegro/models/products/products.dart';
import 'package:my_store/action_create_offer/bindProduct.dart';
import 'package:my_store/action_create_offer/offer_categories.dart';
import 'package:my_store/action_create_offer/offer_description.dart';
import 'package:my_store/action_create_offer/offer_images.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/action_create_offer/offer_param.dart';
import 'package:my_store/action_find_item_on_the_internet/network_search_brain.dart';

class ProductModel {
  Products products;
  String parentCategory = '';

  Future<Products> getProductByEan(String EAN) async {
    final response = await NetworkHelper.getProductData(EAN.split('.')[0]);
    if (response != null) {
      Products product = Products.fromJson(response);
      if (product != null &&
          product.products != null &&
          product.products != []) {
        if (product.products.length != 0) {
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
      return product.products[0].offerTitle;
    } else {
      return getName(productName);
    }
  }

  getProductDescription(Products productJson) {
    if (productJson != null) {
      if (productJson.products[0].offerDescription == null) {
        return null;
      }
      return productJson.products[0].offerDescription;
    } else {
      return null;
    }
  }

  List<Parameter> getParameters(Products productJson) {
    if (productJson != null) {
      return productJson.products[0].parameters;
    }
    return [];
  }

  getCategory(Products productJson) {
    if (productJson != null) {
      return productJson.products[0].category;
    }
  }

  String getCategoryId(Products productJson) {
    if (productJson != null) {
      return productJson.products[0].category.id;
    }
    return '';
  }

  List<Similar> getSimilars(Products productJson) {
    if (productJson != null) {
      return productJson.products[0].category.similars;
    }
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
            parentCategory = category.name + ' -> ' + parentCategory;
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
      TextEditingController nameController,
      String productName,
      OfferParam offerParam,
      OfferImages offerImages,
      OfferDescription offerDescription,
      BindProduct bindProduct,
      Function updateProductData,
      Function updateState) async {
    EasyLoading.show();
    products = await getProductByEan(EAN);
    offerCategories.categoryName = await getCategoryName(products);
    offerDescription.description = await getProductDescription(products);
    myOffer.productCategory = getCategory(products);
    offerParam.getParameters(myOffer, updateState);
    offerParam.parametersVisibility = true;
    if (products == null) {
      bindProduct.bindWithProduct = false;
    } else {
      bindProduct.bindWithProduct = true;
    }
    EasyLoading.dismiss();
    updateProductData();
  }

  setProductData(
      OfferCategories offerCategories,
      OfferParam offerParam,
      OfferImages offerImages,
      List<Photo> imagesFiles,
      BindProduct bindProduct,
      OfferDescription offerDescription,
      OfferModel myOffer) async {
    if (products == null) {
      offerCategories.categoryName = '';
    }
    offerParam.productParameters = getParameters(products);
    offerImages.photosTitle = offerImages.displayPhotosTitle(
        products, imagesFiles, offerImages.photosFromDb);
    myOffer.images = await offerImages.displayAllPhotos(products, myOffer);
    myOffer.description = getDescription(offerDescription.description, myOffer);
    bindProduct.checkIfProductExist(products);
    if (bindProduct.productExist) {
      bindProduct.checkBoxBindProductVisible = true;
      offerCategories.allowChangingCategory = false;
    }

    bindProduct.productQuestion = bindProduct.askProductQuestion();
  }

  TextEditingController getNameController(String productName) {
    return TextEditingController(text: getProductTitle(products, productName));
  }

  TextEditingController getDescriptionController(String description) {
    return TextEditingController(text: description);
  }

  Description getDescription(
      Description productDescription, OfferModel myOffer) {
    if (productDescription != null) {
      myOffer.description.sections.insertAll(4, productDescription.sections);
    }
    return myOffer.description;
  }
}
