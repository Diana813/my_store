import 'package:my_store/action_allegro/allegro_api/post/post_offer.dart';
import 'package:my_store/action_allegro/models/categories/categories.dart';
import 'package:my_store/action_allegro/models/categories/category.dart';
import 'package:my_store/action_allegro/models/products/category/category.dart';
import 'package:my_store/action_create_offer/bindProduct.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/widgets/allegro_form_widgets/category_widget.dart';

import 'offer_param.dart';

class OfferCategories {
  String categoryDropDownValue = '';
  List<Category> categories = [];
  bool allowChangingCategory = true;
  String categoryName = '';

  getCategories(String parentId) async {
    List<Category> cat = [];
    Categories categoriesList = await PostOffer.getCategories(parentId);
    if (categoriesList != null) {
      for (int i = 0; i < categoriesList.categories.length; i++) {
        cat.add(categoriesList.categories.elementAt(i));
      }
    }
    return cat;
  }

  displayCategories() {
    List<String> cat = [];
    if (categories != null) {
      for (Category category in categories) {
        cat.add(category.name);
      }
    }
    return cat;
  }

  getProductCategory(ProductCategory productCategory, Category category) {
    if (category != null) {
      return category;
    } else if (productCategory != null) {
      return productCategory;
    } else {
      return null;
    }
  }

  updateCategories(
      String newValue,
      Function getCategories,
      BindProduct bindProduct,
      OfferModel myOffer,
      Function updateState,
      OfferParam offerParam) async {
    if (categories.elementAt(CategoryPart.indexOfCategory).leaf == false) {
      categoryName = categoryName + newValue + ' -> ';
      await getCategories(
          categories.elementAt(CategoryPart.indexOfCategory).id);
    } else {
      categoryDropDownValue = newValue;
      if (categoryName.endsWith(' -> ')) {
        categoryName = categoryName + newValue;
      } else {
        List<String> cat = categoryName.split(' -> ');
        cat.removeLast();
        categoryName = '';
        for (int i = 0; i < cat.length; i++) {
          categoryName = categoryName + cat.elementAt(i) + ' -> ';
        }
        categoryName = categoryName + newValue;
      }
      showCheckBoxes(bindProduct);
      myOffer.category = categories.elementAt(CategoryPart.indexOfCategory);

      if (offerParam.offerParameters != null)
        print(offerParam.offerParameters.length);
      await offerParam.getParameters(myOffer, updateState);
    }

    updateState();
  }

  showCheckBoxes(BindProduct bindProduct) {
    bindProduct.checkBoxBindingInfoVisible = true;
    bindProduct.canCreateProduct = categories
        .elementAt(CategoryPart.indexOfCategory)
        .options
        .productCreationEnabled;
    bindProduct.canBindWithProduct = categories
        .elementAt(CategoryPart.indexOfCategory)
        .options
        .offersWithProductPublicationEnabled;

    if (bindProduct.productExist == false && bindProduct.canCreateProduct) {
      bindProduct.checkBoxBindProductVisible = true;
      bindProduct.productQuestion = bindProduct.askProductQuestion();
    }
  }
}
