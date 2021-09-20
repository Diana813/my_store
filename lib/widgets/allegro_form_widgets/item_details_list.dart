import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/models/products/description/description.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/action_allegro/models/products/product.dart';
import 'package:my_store/action_create_offer/models/pricing/selling_mode.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/utils/colors.dart';
import 'package:my_store/widgets/allegro_form_widgets/category_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/images_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/offer_title_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/param_widgets/parameters_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/product_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/stock_widget.dart';

import 'description_widgets/description_widget.dart';
import 'selling_mode_widget.dart';

class ItemDetailsList extends StatefulWidget {
  final Product item;
  final Function onTap;
  final Function deletePhoto;
  final String EAN;
  String name;
  List<Parameter> parameters;
  final TextEditingController nameController;
  final String categoryName;
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
  final SellingMode sellingMode;
  final String price;

  ItemDetailsList({
    this.item,
    @required this.onTap,
    @required this.EAN,
    @required this.name,
    @required this.parameters,
    @required this.nameController,
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
    @required this.sellingMode,
    @required this.price,
  });

  @override
  State<ItemDetailsList> createState() => _ItemDetailsListState();
}

class _ItemDetailsListState extends State<ItemDetailsList> {
  var tapPosition;

  var iconButtonColor = Color(ColorsMyStore.AccentColor);

  getColor() {
    iconButtonColor = Color(ColorsMyStore.PrimaryColor);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: <Widget>[
          ImagesPart(
            imageFiles: widget.offer.images,
            onTap: widget.onTap,
            caruselController: widget.caruselController,
            deleteAllPhotos: widget.deleteAllPhotos,
            deletePhoto: widget.deletePhoto,
            photosTitle: widget.photosTitle,
            shouldWarn: widget.shouldWarn,
            warning: widget.warning,
          ),
          TitlePart(nameController: widget.nameController),
          DescriptionPart(
            myOffer: widget.offer,
          ),
          CategoryPart(
            categoryName: widget.categoryName,
            categoryDropDownValue: widget.categoryDropDownValue,
            chooseCategory: widget.chooseCategory,
            categories: widget.categories,
            canBindWithProduct: widget.canBindWithProduct,
            canCreateProduct: widget.canCreateProduct,
            resetCategory: widget.resetCategory,
            bindingInfoVisible: widget.bindingInfoVisible,
          ),
          ProductPart(
            bindWithProduct: widget.bindWithProduct,
            addProductQuestion: widget.addProductQuestion,
            onBindWithProductChange: widget.onBindWithProductChange,
            bindingVisible: widget.bindingVisible,
          ),
          ParametersPart(
            EAN: widget.EAN,
            parameters: widget.parameters,
            offer: widget.offer,
            hideParameters: widget.hideParameters,
            displayOtherParams: widget.displayOtherParams,
            displayRequiredForProductParams:
                widget.displayRequiredForProductParams,
            displayRequiredParams: widget.displayRequiredParams,
            parametersVisibility: widget.parametersVisibility,
          ),
          SellingModePart(
            sellingMode: widget.sellingMode,
            price: widget.price,
          ),
          StockPart(
            offerModel: widget.offer,
          ),
        ],
      ),
    );
  }
}
