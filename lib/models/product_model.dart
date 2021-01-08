class Product {
  bool isDone;
  final String ASIN;
  final String EAN;
  final String name;
  final String totalRetail;
  final String LPN;

  Product(
      {this.isDone = false,
      this.ASIN,
      this.EAN,
      this.name,
      this.totalRetail,
      this.LPN});

  void toggleDone() {
    isDone = !isDone;
  }
}
