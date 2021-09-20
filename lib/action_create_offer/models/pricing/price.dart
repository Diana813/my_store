class Price {
  String amount;
  String currency;

  Price({this.amount, this.currency});

  factory Price.fromJson(dynamic json) {
    return Price(
      amount: json['amount'],
      currency: json['currency'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'currency': currency,
    };
  }
}
