import 'dart:convert';

class ProductModel {
  final String id;
  final DateTime createdAt;
  final String name;
  final String image;
  final double price;
  final bool isPromotional;

  ProductModel({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.image,
    required this.price,
    required this.isPromotional,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] ?? '',
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      price: (json['price'] ?? 0.0).toDouble(),
      isPromotional: json['isPromotional'] ?? false,
    );
  }

  static Map<String, dynamic> toMapJson(final ProductModel productModel) {
    return {
      'id': productModel.id,
      'createdAt': productModel.createdAt.toIso8601String(),
      'name': productModel.name,
      'image': productModel.image,
      'price': productModel.price,
      'isPromotional': productModel.isPromotional,
    };
  }

  static String encode(final List<ProductModel> productModel) => json.encode(
        productModel.map<Map<String, dynamic>>(ProductModel.toMapJson).toList(),
      );

  static List<ProductModel> decode(final String productModel) =>
      (json.decode(productModel) as List)
          .map<ProductModel>((final item) =>
              ProductModel.fromJson(item as Map<String, dynamic>))
          .toList();
}
