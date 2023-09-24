class Product {
  final String id;
  final String name;
  final String image;
  final double price;
  final double oldPrice;

  Product({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    required this.oldPrice,
  });

  static Product fromRemoteJson({required Map<String, dynamic> json}) {
    return Product(
      id: json['productId'],
      name: json['productName'],
      image: json['items'][0]['images'][0]['imageUrl'],
      oldPrice: json['items'][0]['sellers'][0]['commertialOffer']['PriceWithoutDiscount'].toDouble(),
      price: json['items'][0]['sellers'][0]['commertialOffer']['Price'].toDouble(),
    );
  }

  static Product fromLocalJson({required Map<String, dynamic> json}) {
    return Product(
      id: json['id'],
      name: json['name'],
      image: json['image'],
      oldPrice: json['old_price'],
      price: json['price'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'old_price': oldPrice,
    };
  }
}
