import 'package:diletta_store/core/enums/filter_enum.dart';
import 'package:diletta_store/layers/domain/entities/product_entity.dart';

/// Sorts a list of products in alphabetical order, whether ascending or descending.
class FilterByAlphabeticalOrderUseCase {
  List<ProductEntity> call(List<ProductEntity> products, FilterOption order) {
    if (order == FilterOption.ascendingAlphabetical) {
      products.sort((a, b) {
        return a.title.toUpperCase().compareTo(b.title.toUpperCase());
      });
    } else if (order == FilterOption.descendingAlphabetical) {
      products.sort((a, b) {
        return b.title.toUpperCase().compareTo(a.title.toUpperCase());
      });
    }

    return products;
  }
}
