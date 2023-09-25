import 'package:diletta_store/layers/domain/entities/product_entity.dart';

/// Filters a product list to only have products on sale.
class FilterBySaleUseCase {
  List<ProductEntity> call(List<ProductEntity> products) {
    return products.where((product) => product.isSale).toList();
  }
}
