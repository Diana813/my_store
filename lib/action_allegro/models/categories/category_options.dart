class Options {
  /* informacja, czy w danej kategorii
  lub jej podkategoriach można wystawić ofertę
  ogłoszeniową*/
  bool advertisement;

  /*czy w danej
  kategorii ogłoszeniowej cena oferty jest
  opcjonalna*/
  bool advertisementPriceOptional;

  /*czy w danej w danej kategorii możesz
  wiązać ofertę z produktem*/
  bool offersWithProductPublicationEnabled;

  /*czy w danej kategorii możesz
  utworzyć produkt*/
  bool productCreationEnabled;
  bool customParametersEnabled;

  Options(
      {this.advertisement,
      this.advertisementPriceOptional,
      this.offersWithProductPublicationEnabled,
      this.productCreationEnabled,
      this.customParametersEnabled});

  factory Options.fromJson(dynamic json) {
    return Options(
        advertisement: json['advertisement'],
        advertisementPriceOptional: json['advertisementPriceOptional'],
        offersWithProductPublicationEnabled:
            json['offersWithProductPublicationEnabled'],
        productCreationEnabled: json['productCreationEnabled'],
        customParametersEnabled: json['customParametersEnabled']);
  }


  Map<String, dynamic> toJson() {
    return {
      'advertisement': advertisement,
      'advertisementPriceOptional': advertisementPriceOptional,
      'offersWithProductPublicationEnabled': offersWithProductPublicationEnabled,
      'productCreationEnabled': productCreationEnabled,
      'customParametersEnabled': customParametersEnabled
    };
  }
}
