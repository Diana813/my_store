import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_store/action_allegro/allegro_api/post/post_offer.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameter.dart';
import 'package:my_store/action_allegro/models/offer_parameter/offer_parameters.dart';
import 'package:my_store/action_allegro/models/products/parameters/parameter.dart';
import 'package:my_store/widgets/allegro_form_widgets/param_widgets/dynamic_multi_choice_dictionary_param.dart';
import 'package:my_store/widgets/allegro_form_widgets/param_widgets/dynamic_range_parameter.dart';
import 'package:my_store/widgets/allegro_form_widgets/param_widgets/dynamic_single_choice_dictionary_param.dart';
import 'package:my_store/widgets/allegro_form_widgets/param_widgets/dynamic_string_param_list.dart';
import 'package:my_store/widgets/allegro_form_widgets/param_widgets/dynamic_text_fields.dart';

import 'models/parameter.dart';
import 'offer_model.dart';

class OfferParam {
  List<Parameter> productParameters;
  List<OfferParameter> offerParameters;
  List<OfferParameter> requiredParams = [];
  List<OfferParameter> requiredForProductParams = [];
  List<OfferParameter> otherParams = [];
  bool parametersVisibility = false;
  List<MyParameter> myOfferParametersList = [];

  getParameters(OfferModel offer, Function updateState) async {
    OfferParameters params = await PostOffer.getParameters(offer);
    if (params == null) {
      parametersVisibility = false;
      return;
    }
    parametersVisibility = true;
    offerParameters = [];
    offerParameters.addAll(params.parameters);
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

  checkIfParameterIsEAN(OfferParameter param, String EAN) {
    if (param.name == 'EAN') {
      return EAN;
    } else {
      return null;
    }
  }

  List<Widget> displayParams(
      List<OfferParameter> params, Function updateState, String EAN) {
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
                Expanded(child: displayParameter(params.elementAt(i), EAN)),
              ],
            ),
          ),
          Divider(),
        ],
      ));
    }
    return parametersList;
  }

  Widget displayDictionaryParameter(OfferParameter param) {
    List<String> dictionaryItems = [];

    if (param.restrictions.multipleChoices == false) {
      for (int i = 0; i < param.dictionary.length; i++) {
        dictionaryItems.add(param.dictionary.elementAt(i).value);
      }
      return SingleChoiceDictionaryParam(
        itemsList: dictionaryItems,
        param: param,
        myOfferParametersList: myOfferParametersList,
      );
    } else {
      for (int i = 0; i < param.dictionary.length; i++) {
        dictionaryItems.add(param.dictionary.elementAt(i).value);
      }
      return MultiChoiceDictionaryParam(
        items: dictionaryItems,
        param: param,
        myOfferParametersList: myOfferParametersList,
      );
    }
  }

  Widget displayStringParameter(OfferParameter param, String EAN) {
    String myEAN = checkIfParameterIsEAN(param, EAN);
    if (param.restrictions.allowedNumberOfValues != null &&
        param.restrictions.allowedNumberOfValues != 1) {
      return StringParamList(
        myOfferParametersList: myOfferParametersList,
        param: param,
      );
    } else {
      return ParameterTextField(
        EAN: myEAN,
        param: param,
        myOfferParametersList: myOfferParametersList,
      );
    }
  }

  Widget displayParameter(OfferParameter param, String EAN) {
    if (param.type == 'dictionary') {
      return displayDictionaryParameter(param);
    } else if (param.restrictions.range == true) {
      return RangeParameter(
        param: param,
        myOfferParametersList: myOfferParametersList,
      );
    } else {
      return displayStringParameter(param, EAN);
    }
  }

  static String createHintString(OfferParameter param) {
    String hint = '';
    if (param.restrictions.min != null) {
      hint = 'min: ' + param.restrictions.min.toString();
    }
    if (param.restrictions.max != null) {
      hint = hint + ', max: ' + param.restrictions.max.toString();
    }

    if (param.restrictions.precision != null) {
      hint = hint + ', precyzja: ' + param.restrictions.precision.toString();
    }

    if (param.restrictions.min == null && param.restrictions.max == null) {
      hint = 'Wpisz wartość';
    }
    return hint;
  }
}
