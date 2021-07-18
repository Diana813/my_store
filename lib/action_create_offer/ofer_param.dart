import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/allegro_api/post/post_offer.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameters.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/utils/colors.dart';

import 'offer_model.dart';

class OfferParam {
  bool required = false;
  bool requiredForProduct = false;
  bool changeEnabled = true;
  List<Parameter> productParameters;
  List<OfferParameter> offerParameters;
  List<OfferParameter> requiredParams = [];
  List<OfferParameter> requiredForProductParams = [];
  List<OfferParameter> otherParams = [];
  Function chooseOneOption;

  getParameters(OfferModel offer, Function updateState) async {
    OfferParameters param = await PostOffer.getParameters(offer);
    if (param == null) {
      return;
    }
    offerParameters = [];
    offerParameters.addAll(param.parameters);
    sortOfferParameters();
    updateState();
  }

  sortOfferParameters() {
    if (offerParameters == null || offerParameters.isEmpty) {
      return;
    }
    for (int i = 0; i < offerParameters.length; i++) {
      if (offerParameters.elementAt(i).required) {
        requiredParams.add(offerParameters.elementAt(i));
      } else if (offerParameters.elementAt(i).requiredForProduct) {
        requiredForProductParams.add(offerParameters.elementAt(i));
      } else {
        otherParams.add(offerParameters.elementAt(i));
      }
    }
  }

  List<Widget> displayParams(List<OfferParameter> params) {
    List<Widget> parametersList = [];
    if (params == null || params.isEmpty) {
      return [];
    }
    for (int i = 0; i < params.length; i++) {
      parametersList.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  child: Text(
                    params.elementAt(i).name,
                    style: TextStyle(fontSize: 16),
                  ),
                  width: 300,
                ),
                displayDictionaryParameters(params.elementAt(i)),
              ],
            ),
          ),
          Divider(),
        ],
      ));
    }
    return parametersList;
  }

  Widget displayDictionaryParameters(OfferParameter param) {
    List<String> dictionaryItems = [];
    if (param.type != 'dictionary') return Container();

    if (param.restrictions.multipleChoices == false) {
      for (int i = 0; i < param.dictionary.length; i++) {
        dictionaryItems.add(param.dictionary.elementAt(i).value);
      }
      return dictionaryWidget(
          param,
          dictionaryItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(fontSize: 16),
              ),
            );
          }).toList());
    } else {
      for (int i = 0; i < param.dictionary.length; i++) {
        dictionaryItems.add(param.dictionary.elementAt(i).value);
      }
      return dictionaryWidget(
          param,
          dictionaryItems.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value,
                    style: TextStyle(fontSize: 16),
                  ),
                  Checkbox(value: false, onChanged: (value) {}),
                ],
              ),
            );
          }).toList());
    }
  }

  Widget dictionaryWidget(
      OfferParameter param, List<DropdownMenuItem<String>> itemsList) {
    String choiceValue = param.dictionary.first.value;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      child: SizedBox(
        width: 300,
        child: DropdownButton<String>(
            isExpanded: true,
            value: choiceValue,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Color(ColorsMyStore.AccentColor),
            ),
            iconSize: 24,
            elevation: 16,
            style: const TextStyle(color: Colors.black),
            underline: Container(
              height: 2,
              color: Color(ColorsMyStore.PrimaryColor),
            ),
            onChanged: (value) {
              choiceValue = value;
            },
            items: itemsList),
      ),
    );
  }

  Widget displayIntegerParameters(OfferParameter param){}
  Widget displayFloatParameters(OfferParameter param){}
  Widget displayStringParameters(OfferParameter param){}

  getProductParametersValues() {}

  displayRequiredParameters() {}

  displayRequiredForProductParameters() {}

  displayOtherParameters() {}

  addParametersToMyOffer() {}
}
