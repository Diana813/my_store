import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:my_store/action_find_item_on_the_internet/network_search_brain.dart';
import 'package:my_store/action_open_file/brain/file_picker_brain.dart';
import 'package:my_store/action_post/brain/allegro_form_screen_brain.dart';
import 'package:my_store/action_post/models/products/parameters/parameter.dart';
import 'package:my_store/action_post/models/products/product.dart';
import 'package:my_store/widgets/app_window.dart' as app_window;
import 'package:my_store/widgets/item_details_list.dart';
import 'package:my_store/widgets/launch_buttons.dart';
import 'package:my_store/widgets/window_buttons.dart';

class AllegroForm extends StatefulWidget {
  AllegroForm({Key key, this.product}) : super(key: key);
  final product;
  List<String> imagesFiles;
  List<String> miniImageFiles;

  @override
  _AllegroFormState createState() => _AllegroFormState();
}

class _AllegroFormState extends State<AllegroForm> {
  String _amazonName;
  String _allegroName;
  String _description;
  String _category;
  List<Parameter> _parameters;
  ProductJson _productJson;
  TextEditingController _nameController;
  TextEditingController _descriptionController;
  TextEditingController _categoryController;
  final controller = CarouselController();

  @override
  void initState() {
    super.initState();
    _getProduct();
  }

  _getProduct() async {
    EasyLoading.show();
    var response =
        await AllegroBrain.getProductByEan(widget.product.EAN.toString());
    _category = await AllegroBrain.getCategoryName(response);
    EasyLoading.dismiss();
    setState(() {
      _productJson = response;
      _allegroName =
          AllegroBrain.getProductTitle(_productJson, widget.product.name);
      _description = AllegroBrain.getProductDescription(_productJson);
      _nameController = TextEditingController(
          text:
              AllegroBrain.getProductTitle(_productJson, widget.product.name));
      _descriptionController = TextEditingController(text: _description);
      _categoryController = TextEditingController(text: _category);
      _parameters = AllegroBrain.getParameters(_productJson);
    });
  }

  @override
  Widget build(BuildContext context) {
    return WindowBorder(
      color: Colors.black87,
      width: 1,
      child: app_window.AppWindow(
          new Scaffold(
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
                      String name = widget.product.name;
                      NetworkSearchBrain.launchURL(
                          'https://google.com/search?q=$name');
                    },
                    launchURLCeneo: () {
                      NetworkSearchBrain.launchURL(
                          'https://ceneo.pl/;szukaj-$_amazonName');
                    },
                    launchURLAllegro: () {
                      NetworkSearchBrain.launchURL(
                          'https://allegro.pl/listing?string=$_amazonName');
                    },
                    launchURLYouTube: () {
                      NetworkSearchBrain.launchURL(
                          'https://www.youtube.com/results?search_query=$_amazonName');
                    },
                  ),
                ),
                Container(
                  child: ItemDetailsList(
                    onTap: () {
                      var file = FilePickerBrain.openImageFile();
                      if (widget.imagesFiles == null) {
                        widget.imagesFiles = [];
                      }
                      widget.imagesFiles.add(file);
                      setState(() {});
                    },
                    imageFiles: AllegroBrain.getPhotoUrls(
                                _productJson, widget.imagesFiles) ==
                            null
                        ? widget.imagesFiles
                        : AllegroBrain.getPhotoUrls(
                            _productJson, widget.imagesFiles),
                    name: _allegroName == null ? _amazonName : _allegroName,
                    EAN: widget.product.EAN.toString().split('.')[0],
                    onTapMini: () async {
                      var file = FilePickerBrain.openImageFile();
                      if (widget.miniImageFiles == null) {
                        widget.miniImageFiles = [];
                      }
                      widget.miniImageFiles.add(file);
                      setState(() {});
                    },
                    miniImageFiles: widget.miniImageFiles,
                    description: _description == null ? '' : _description,
                    nameController: _nameController,
                    descriptionController: _descriptionController,
                    caruselController: controller,
                    categoryController: _categoryController,
                    parameters: _parameters == null ? [] : _parameters,
                  ),
                )
              ],
            ),
          ),
          WindowButtons()),
    );
  }
}
