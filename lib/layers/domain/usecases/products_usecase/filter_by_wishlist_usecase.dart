import 'package:diletta_store/layers/domain/entities/product_entity.dart';

/// Filters a product list to only have products that the user has wishlisted.
class FilterByWishlistUseCase {
  List<ProductEntity> call(List<ProductEntity> products) {
    return products.where((product) => product.isFavorite).toList();
  }
}