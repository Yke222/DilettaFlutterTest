class ProductEntity {
  final int id;
  final String title;
  final String description;
  final double price;
  final double discount;
  final String imageUrl;
  bool isFavorite;

  ProductEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discount,
    required this.imageUrl,
    this.isFavorite = false,
  });

  bool get isSale {
    // Every product with 11% or more discount will be considered an offer.
    return discount >= 11.0;
  }
}
