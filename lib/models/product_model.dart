class Product {
  bool at_the_auction;
  bool sold;
  final String shipmentDate;
  final String ASIN;
  final String EAN;
  final String name;
  final String totalRetail;
  final String LPN;

  Product(
      {this.at_the_auction = false,
      this.sold = false,
      this.shipmentDate,
      this.ASIN,
      this.EAN,
      this.name,
      this.totalRetail,
      this.LPN});

}
