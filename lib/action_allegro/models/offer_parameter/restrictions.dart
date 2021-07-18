class Restrictions {
  var min;
  var max;
  var range;
  var multipleChoices;
  var precision;
  var minLength;
  var maxLength;
  var allowedNumberOfValues;

  Restrictions({
    this.min,
    this.max,
    this.range,
    this.multipleChoices,
    this.precision,
    this.minLength,
    this.maxLength,
    this.allowedNumberOfValues,
  });

  factory Restrictions.fromJson(dynamic json) {
    return Restrictions(
      min: json['min'],
      max: json['max'],
      range: json['range'],
      multipleChoices: json['multipleChoices'],
      precision: json['precision'],
      minLength: json['minLength'],
      maxLength: json['maxLength'],
      allowedNumberOfValues: json['allowedNumberOfValues'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'min': min,
      'max': max,
      'range': range,
      'multipleChoices': multipleChoices,
      'precision': precision,
      'minLength': minLength,
      'maxLength': maxLength,
      'allowedNumberOfValues': allowedNumberOfValues,
    };
  }
}
