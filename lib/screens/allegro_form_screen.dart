import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/action_allegro/allegro_api/post/post_offer.dart';
import 'package:my_store/action_allegro/product/product_model.dart';
import 'package:my_store/action_create_offer/bindProduct.dart';
import 'package:my_store/action_create_offer/offer_categories.dart';
import 'package:my_store/action_create_offer/offer_images.dart';
import 'package:my_store/action_create_offer/offer_model.dart';
import 'package:my_store/action_create_offer/offer_param.dart';
import 'package:my_store/action_find_item_on_the_internet/network_search_brain.dart';
import 'package:my_store/action_mysql/my_offers_table.dart';
import 'package:my_store/action_open_file/brain/file_picker_brain.dart';
import 'package:my_store/utils/date.dart';
import 'package:my_store/widgets/allegro_form_widgets/item_details_list.dart';
import 'package:my_store/widgets/allegro_form_widgets/publishing_widget.dart';
import 'package:my_store/widgets/allegro_form_widgets/unfocuser.dart';
import 'package:my_store/widgets/app_window.dart' as app_window;
import 'package:my_store/widgets/launch_buttons.dart';
import 'package:my_store/widgets/window_buttons.dart';

class AllegroForm extends StatefulWidget {
  AllegroForm({Key key, this.product}) : super(key: key);
  final product;
  final List<String> imagesFiles = [];

  @override
  _AllegroFormState createState() => _AllegroFormState();
}

class _AllegroFormState extends State<AllegroForm> {
  String _description;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  final controller = CarouselController();
  bool addToDbValue = false;
  bool draftDoneVisibility = false;
  bool activeOfferDoneVisibility = false;
  OfferCategories offerCategories = new OfferCategories();
  BindProduct bindProduct = new BindProduct();
  OfferModel myOffer = new OfferModel();
  OfferImages offerImages = new OfferImages();
  OfferParam offerParam = new OfferParam();
  ProductModel productModel = new ProductModel();

  @override
  void initState() {
    super.initState();
    getPhotosFromDb();
    productModel.getProduct(
        widget.product.EAN.toString().split('.')[0],
        offerCategories,
        myOffer,
        _description,
        _nameController,
        widget.product.name,
        _descriptionController,
        offerParam,
        offerImages,
        widget.imagesFiles,
        bindProduct,
        updateProductData);
    MyOffersTable.addEANToTableMyOffer(
        widget.product.EAN.toString().split('.')[0], Date.getDate());
    MyOffersTable.updateDate(
        widget.product.EAN.toString().split('.')[0], Date.getDate());
    getCategories(null);
  }

  @override
  void dispose() {
    if (_nameController != null) this._nameController.dispose();
    if (_descriptionController != null) this._descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Colors.black87,
      width: 1,
      child: app_window.AppWindow(
          Unfocuser(
            child: Scaffold(
              appBar: AppBar(
                title: Text('My Store'),
              ),
              body: ListView(
                children: [
                  Container(
                    child: LaunchUrl(
                      launchURLAmazon: () {
                        EasyLoading.show();
                        String ASIN = widget.product.ASIN;
                        NetworkSearchBrain.checkResponseAmazon(ASIN, context);
                      },
                      launchURLGoogle: () {
                        String name = _nameController.text;
                        NetworkSearchBrain.launchURL(
                            'https://google.com/search?q=$name');
                      },
                      launchURLCeneo: () {
                        String name = _nameController.text;
                        NetworkSearchBrain.launchURL(
                            'https://ceneo.pl/;szukaj-$name');
                      },
                      launchURLAllegro: () {
                        String name = _nameController.text;
                        NetworkSearchBrain.launchURL(
                            'https://allegro.pl/listing?string=$name');
                      },
                      launchURLYouTube: () {
                        String name = _nameController.text;
                        NetworkSearchBrain.launchURL(
                            'https://www.youtube.com/results?search_query=$name');
                      },
                    ),
                  ),
                  Container(
                    child: ItemDetailsList(
                      onTap: () {
                        var files = FilePickerBrain.openImageFiles();
                        offerImages.photos = offerImages.addOwnPhotosToTheList(
                            files, offerImages.photos);
                        offerImages.photosTitle = offerImages.displayPhotosTitle(
                            productModel.products,
                            offerImages.photos,
                            offerImages.photosFromDb);
                        setState(() {});
                      },
                      imageFiles: offerImages.photos,
                      name: _nameController == null ? '' : _nameController.text,
                      EAN: widget.product.EAN.toString().split('.')[0],
                      description: _description == null ? '' : _description,
                      nameController: _nameController,
                      descriptionController: _descriptionController,
                      caruselController: controller,
                      categoryName: offerCategories.categoryName == null
                          ? ''
                          : offerCategories.categoryName,
                      parameters: offerParam.productParameters == null
                          ? []
                          : offerParam.productParameters,
                      deleteAllPhotos: () async {
                        await offerImages.deleteListOfPhotos(offerImages.photos,
                            widget.product.EAN.toString().split('.')[0]);
                        setState(() {});
                      },
                      deletePhoto: (index, context, tapPosition) async {
                        offerImages.showPopupMenuToDeletePhoto(
                            context,
                            tapPosition,
                            widget.product.EAN.toString().split('.')[0],
                            productModel,
                            index,
                            updateState);
                      },
                      photosTitle: offerImages.photosTitle,
                      chooseCategory:
                          offerCategories.allowChangingCategory == false
                              ? null
                              : (String newValue) {
                                  offerCategories.updateCategories(
                                      newValue,
                                      getCategories,
                                      bindProduct,
                                      myOffer,
                                      updateState,
                                      offerParam);
                                },
                      categoryDropDownValue:
                          offerCategories.categoryDropDownValue,
                      categories: offerCategories.displayCategories(),
                      canCreateProduct: bindProduct.canCreateProduct,
                      canBindWithProduct: bindProduct.canBindWithProduct,
                      resetCategory: () {
                        offerCategories.categoryName = '';
                        offerCategories.allowChangingCategory = true;
                        bindProduct.checkBoxBindingInfoVisible = false;
                        bindProduct.checkBoxBindProductVisible = false;
                        if (offerParam.offerParameters.isNotEmpty) {
                          offerParam.offerParameters.clear();
                          offerParam.requiredForProductParams.clear();
                          offerParam.requiredParams.clear();
                          offerParam.otherParams.clear();
                          offerParam.parametersVisibility = false;
                        }
                        getCategories(null);
                      },
                      addProductQuestion: bindProduct.productQuestion,
                      onBindWithProductChange: (bool value) {
                        setState(() {
                          bindProduct.bindWithProduct = value;
                          bindProduct.setProductId(
                              productModel.products, myOffer);
                        });
                      },
                      bindWithProduct: bindProduct.bindWithProduct,
                      bindingVisible: bindProduct.checkBoxBindProductVisible,
                      bindingInfoVisible: bindProduct.checkBoxBindingInfoVisible,
                      warning:
                          offerImages.imageListLimitWarning(offerImages.photos),
                      shouldWarn: offerImages.shouldWarn,
                      offer: myOffer,
                      hideParameters: () {
                        if (offerParam.parametersVisibility) {
                          offerParam.parametersVisibility = false;
                        } else {
                          offerParam.parametersVisibility = true;
                        }
                        setState(() {});
                      },
                      displayRequiredParams: offerParam.displayParams(
                          offerParam.requiredParams,
                          updateState,
                          widget.product.EAN.toString().split('.')[0]),
                      displayRequiredForProductParams: offerParam.displayParams(
                          offerParam.requiredForProductParams,
                          updateState,
                          widget.product.EAN.toString().split('.')[0]),
                      displayOtherParams: offerParam.displayParams(
                          offerParam.otherParams,
                          updateState,
                          widget.product.EAN.toString().split('.')[0]),
                      parametersVisibility:
                          offerParam.parametersVisibility == null
                              ? false
                              : offerParam.parametersVisibility,
                    ),
                  ),
                  CheckboxListTile(
                    value: addToDbValue,
                    onChanged: (value) async {
                      if (offerImages.photosFromDb.isNotEmpty) {
                        await MyOffersTable.deletePhotoURLs(
                            widget.product.EAN.toString().split('.')[0]);
                      }
                      await offerImages.addPhotosToDb(offerImages.photos,
                          widget.product.EAN.toString().split('.')[0]);
                      setState(() {
                        addToDbValue = value;
                      });
                    },
                    title: Text('To jest wzorcowa oferta dla tego produktu'),
                  ),
                  PublishingPart(
                    draftDoneVisibility: draftDoneVisibility,
                    publishDraft: () async {
                      EasyLoading.show();
                      await setMyOffer();
                      EasyLoading.dismiss();
                      int statusCode = await PostOffer.createDraft(
                          myOffer,
                          offerCategories.getProductCategory(
                              myOffer.productCategory, myOffer.category));
                      if (statusCode == 200) {
                        setState(() {
                          draftDoneVisibility = true;
                        });
                        await Future.delayed(Duration(seconds: 1));
                        setState(() {
                          draftDoneVisibility = false;
                        });
                      }
                    },
                    activeOfferDoneVisibility: activeOfferDoneVisibility,
                    publishOffer: () async {
                      EasyLoading.show();
                      await setMyOffer();
                      EasyLoading.dismiss();
                      int statusCode = await PostOffer.createDraft(
                          myOffer,
                          offerCategories.getProductCategory(
                              myOffer.productCategory, myOffer.category));
                      if (statusCode == 200) {
                        setState(() {
                          activeOfferDoneVisibility = true;
                        });
                        await Future.delayed(Duration(seconds: 1));
                        setState(() {
                          activeOfferDoneVisibility = false;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          WindowButtons()),
    );
  }

  getPhotosFromDb() async {
    offerImages.photosFromDb = await OfferImages.getPhotosFromDb(
        widget.product.EAN.toString().split('.')[0]);
  }

  getCategories(String parentId) async {
    offerCategories.categories = await offerCategories.getCategories(parentId);
    if (offerCategories.categories.isNotEmpty) {
      setState(() {
        offerCategories.categoryDropDownValue =
            offerCategories.categories.first.name;
      });
    }
  }

  updateState() {
    setState(() {});
  }

  updateProductData() {
    setState(() {
      _description = productModel.getDescription();
      _nameController = productModel.getNameController(widget.product.name);
      _descriptionController =
          productModel.getDescriptionController(_description);
      productModel.setProductData(offerCategories, offerParam, offerImages,
          widget.imagesFiles, bindProduct);
    });
  }

  setMyOffer() async {
    myOffer.title = _nameController.text;
    myOffer.images = await offerImages.setMyOfferImages();
    myOffer.parameters = offerParam.myOfferParametersList;
  }
}
