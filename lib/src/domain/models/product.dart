class Product {
  String id;
  String createdAt;
  String product;
  String productName;
  String productImage;
  String productAmount;

  Product({
    required this.id,
    required this.createdAt,
    required this.product,
    required this.productName,
    required this.productImage,
    required this.productAmount,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      createdAt: json['createdAt'],
      product: json['product'],
      productName: json['productName'],
      productImage: json['productImage'],
      productAmount: json['productAmount'],
    );
  }
}
