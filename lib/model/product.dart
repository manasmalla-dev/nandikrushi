class Product {
  late String category;
  late String subcategory;
  late String units;
  late int quantity;
  late double price;
  late String description;
  late String productImage;
  Product(
      {required this.category,
      required this.subcategory,
      required this.units,
      required this.quantity,
      required this.price,
      required this.description,
      required this.productImage});
  @override
  String toString() {
    // TODO: implement toString
    return "$category > $subcategory - $quantity $units - ₹$price : $description : $productImage";
  }
}
