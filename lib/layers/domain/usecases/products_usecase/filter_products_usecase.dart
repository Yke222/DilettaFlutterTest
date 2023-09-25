import 'package:diletta_store/core/enums/filter_enum.dart';
import 'package:diletta_store/layers/domain/entities/product_entity.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/filter_by_price_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/filter_by_sale_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/filter_by_wishlist_usecase.dart';

import 'filter_by_alphabetical_order_usecase.dart';

/// Filter products by the requested filters.
class FilterProductsUseCase {
  late final FilterByWishlistUseCase _filterByWishlistUseCase;
  late final FilterBySaleUseCase _filterBySaleUseCase;
  late final FilterByPriceUseCase _filterByPriceUseCase;
  late final FilterByAlphabeticalOrderUseCase _filterByAlphabeticalOrderUseCase;

  FilterProductsUseCase({
    required FilterBySaleUseCase filterBySaleUseCase,
    required FilterByWishlistUseCase filterByWishlistUseCase,
    required FilterByPriceUseCase filterByPriceUseCase,
    required FilterByAlphabeticalOrderUseCase filterByAlphabeticalOrderUseCase,
  }) {
    _filterBySaleUseCase = filterBySaleUseCase;
    _filterByWishlistUseCase = filterByWishlistUseCase;
    _filterByPriceUseCase = filterByPriceUseCase;
    _filterByAlphabeticalOrderUseCase = filterByAlphabeticalOrderUseCase;
  }

  List<ProductEntity> call(
    List<ProductEntity> products,
    List<FilterOption> filters,
  ) {
    if (filters.contains(FilterOption.onlySale)) {
      products = _filterBySaleUseCase(products);
    }

    if (filters.contains(FilterOption.wishlist)) {
      products = _filterByWishlistUseCase(products);
    }

    if (filters.contains(FilterOption.ascendingAlphabetical)) {
      products = _filterByAlphabeticalOrderUseCase(
        products,
        FilterOption.ascendingAlphabetical,
      );
    }

    if (filters.contains(FilterOption.descendingAlphabetical)) {
      products = _filterByAlphabeticalOrderUseCase(
        products,
        FilterOption.descendingAlphabetical,
      );
    }

    if (filters.contains(FilterOption.ascendingPrice)) {
      products = _filterByPriceUseCase(
        products,
        FilterOption.ascendingPrice,
      );
    }

    if (filters.contains(FilterOption.descendingPrice)) {
      products = _filterByPriceUseCase(
        products,
        FilterOption.descendingPrice,
      );
    }

    return products;
  }
}
