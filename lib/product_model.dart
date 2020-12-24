class Product {
  bool isDone;
  final String EAN;
  final String name;
  final String totalRetail;
  final String LPN;

  Product({this.isDone = false, this.EAN, this.name,this.totalRetail, this.LPN});

  void toggleDone() {
    isDone = !isDone;
  }
}
