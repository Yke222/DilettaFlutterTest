import 'package:diletta_store/layers/domain/entities/product_entity.dart';

/// Filters the product list to only have products with a certain term.
class SearchTermUseCase {
  List<ProductEntity> call(List<ProductEntity> products, String term) {
    if (term.isEmpty) return products;

    return products.where(
      (product) {
        return product.title.toUpperCase().contains(
          term.toUpperCase(),
        );
      },
    ).toList();
  }
}
