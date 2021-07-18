
import 'offer_parameter.dart';

class OfferParameters {
  List<OfferParameter> parameters;

  OfferParameters({this.parameters});

  factory OfferParameters.fromJson(dynamic json) {
    if (json['parameters'] != null) {
      var objsJson = json['parameters'] as List;
      List<OfferParameter> _parameters =
          objsJson.map((tagJson) => OfferParameter.fromJson(tagJson)).toList();

      return OfferParameters(parameters: _parameters);
    } else
      return null;
  }

  Map<String, dynamic> toJson() {
    return {
      'parameters': parameters,
    };
  }
}
