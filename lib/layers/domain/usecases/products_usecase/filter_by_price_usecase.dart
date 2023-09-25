import 'package:diletta_store/core/enums/filter_enum.dart';
import 'package:diletta_store/layers/domain/entities/product_entity.dart';

/// Sorts a list of products by price, whether ascending or descending.
class FilterByPriceUseCase {
  List<ProductEntity> call(List<ProductEntity> products, FilterOption order) {
    if (order == FilterOption.ascendingPrice) {
      products.sort((a, b) => a.price.compareTo(b.price));
    } else if (order == FilterOption.descendingPrice) {
      products.sort((a, b) => b.price.compareTo(a.price));
    }

    return products;
  }
}
