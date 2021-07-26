import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/action_allegro/models/products/product.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/utils/colors.dart';
import 'package:my_store/widgets/allegro_form_widgets/category_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/images_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/offer_title_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/param_widgets/parameters_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/product_widget.dart';

import 'description_widget.dart';

class ItemDetailsList extends StatelessWidget {
  final Product item;
  List<String> imageFiles;
  final Function onTap;
  final Function deletePhoto;
  var tapPosition;
  final String EAN;
  String name;
  String description;
  List<Parameter> parameters;
  final TextEditingController nameController;
  final TextEditingController descriptionController;
  final String categoryName;
  var iconButtonColor = Color(ColorsMyStore.AccentColor);
  final CarouselController caruselController;
  final Function deleteAllPhotos;
  final String photosTitle;
  final String categoryDropDownValue;
  final Function chooseCategory;
  final List<String> categories;
  final bool canBindWithProduct;
  final bool canCreateProduct;
  final bool bindingInfoVisible;
  final bool bindingVisible;
  final Function resetCategory;
  final bool bindWithProduct;
  final String addProductQuestion;
  final Function onBindWithProductChange;
  final String warning;
  final bool shouldWarn;
  final OfferModel offer;
  final List<Widget> displayRequiredParams;
  final List<Widget> displayRequiredForProductParams;
  final List<Widget> displayOtherParams;
  final Function hideParameters;
  final bool parametersVisibility;

  ItemDetailsList({
    this.item,
    @required this.imageFiles,
    @required this.onTap,
    @required this.EAN,
    @required this.name,
    @required this.description,
    @required this.parameters,
    @required this.nameController,
    @required this.descriptionController,
    @required this.categoryName,
    @required this.caruselController,
    @required this.deleteAllPhotos,
    @required this.deletePhoto,
    @required this.photosTitle,
    @required this.categoryDropDownValue,
    @required this.chooseCategory,
    @required this.categories,
    @required this.canBindWithProduct,
    @required this.canCreateProduct,
    @required this.bindingInfoVisible,
    @required this.bindingVisible,
    @required this.resetCategory,
    @required this.bindWithProduct,
    @required this.addProductQuestion,
    @required this.onBindWithProductChange,
    @required this.warning,
    @required this.shouldWarn,
    @required this.offer,
    @required this.displayRequiredParams,
    @required this.displayRequiredForProductParams,
    @required this.displayOtherParams,
    @required this.hideParameters,
    @required this.parametersVisibility,
  });

  getColor() {
    iconButtonColor = Color(ColorsMyStore.PrimaryColor);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          ImagesPart(
            imageFiles: imageFiles,
            onTap: onTap,
            caruselController: caruselController,
            deleteAllPhotos: deleteAllPhotos,
            deletePhoto: deletePhoto,
            photosTitle: photosTitle,
            shouldWarn: shouldWarn,
            warning: warning,
          ),
          TitlePart(nameController: nameController),
          DescriptionPart(descriptionController: descriptionController),
          CategoryPart(
            categoryName: categoryName,
            categoryDropDownValue: categoryDropDownValue,
            chooseCategory: chooseCategory,
            categories: categories,
            canBindWithProduct: canBindWithProduct,
            canCreateProduct: canCreateProduct,
            resetCategory: resetCategory,
            bindingInfoVisible: bindingInfoVisible,
          ),
          ProductPart(
            bindWithProduct: bindWithProduct,
            addProductQuestion: addProductQuestion,
            onBindWithProductChange: onBindWithProductChange,
            bindingVisible: bindingVisible,
          ),
          ParametersPart(
            EAN: EAN,
            parameters: parameters,
            offer: offer,
            hideParameters: hideParameters,
            displayOtherParams: displayOtherParams,
            displayRequiredForProductParams: displayRequiredForProductParams,
            displayRequiredParams: displayRequiredParams,
            parametersVisibility: parametersVisibility,
          ),
        ],
      ),
    );
  }
}
