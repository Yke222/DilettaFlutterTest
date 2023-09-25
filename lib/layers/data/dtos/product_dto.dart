import 'package:diletta_store/layers/domain/entities/product_entity.dart';

/// Responsible for serializing a remotely obtained product to a domain entity.
class ProductDTO extends ProductEntity {
  final double discountPercentage;
  final String thumbnail;

  ProductDTO({
    required super.id,
    required super.title,
    required super.description,
    required super.price,
    required this.discountPercentage,
    required this.thumbnail,
  }) : super(discount: discountPercentage, imageUrl: thumbnail);

  factory ProductDTO.fromJson(Map<String, dynamic> productJson) {
    return ProductDTO(
      id: productJson['id'],
      title: productJson['title'],
      description: productJson['description'],
      price: double.parse(productJson['price'].toString()),
      discountPercentage: productJson['discountPercentage'],
      thumbnail: productJson['thumbnail'],
    );
  }
}
