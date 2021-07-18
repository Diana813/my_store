class ParameterOptions {
  bool variantsAllowed;
  bool variantsEqual;

  /*id wartości niejednoznacznej, np.
  "inna", "pozostałe", etc*/
  String ambiguousValueId;

  /*id parametru, od którego zależne są
  dostępne wartości tego parametru*/
  String dependsOnParameterId;

  /*id wartości parametru warunkującego
  (głównego), od której zależy, czy parametr jest wymagany*/
  List<dynamic> requiredDependsOnValueIds;

  /*zbiór identyfikatorów wartości
  parametru warunkującego, od których zależy, czy dany parametr będzie
  widoczny*/
  List<dynamic> displayDependsOnValueIds;
  bool describesProduct;
  bool customValuesEnabled;

  ParameterOptions(
      {this.variantsAllowed,
      this.variantsEqual,
      this.ambiguousValueId,
      this.dependsOnParameterId,
      this.requiredDependsOnValueIds,
      this.displayDependsOnValueIds,
      this.describesProduct,
      this.customValuesEnabled});

  factory ParameterOptions.fromJson(Map<String, dynamic> json) {
    return ParameterOptions(
      variantsAllowed: json['variantsAllowed'],
      variantsEqual: json['variantsEqual'],
      ambiguousValueId: json['ambiguousValueId'] as String,
      dependsOnParameterId: json['dependsOnParameterId'] as String,
      requiredDependsOnValueIds: json['requiredDependsOnValueIds'] as List,
      displayDependsOnValueIds: json['displayDependsOnValueIds'] as List,
      describesProduct: json['describesProduct'],
      customValuesEnabled: json['customValuesEnabled'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variantsAllowed': variantsAllowed,
      'variantsEqual': variantsEqual,
      'ambiguousValueId': ambiguousValueId,
      'dependsOnParameterId': dependsOnParameterId,
      'requiredDependsOnValueIds': requiredDependsOnValueIds,
      'displayDependsOnValueIds': displayDependsOnValueIds,
      'describesProduct': describesProduct,
      'customValuesEnabled': customValuesEnabled,
    };
  }
}
