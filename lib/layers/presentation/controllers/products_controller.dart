import 'package:diletta_store/core/constants/error_constants.dart';
import 'package:diletta_store/core/enums/filter_enum.dart';
import 'package:diletta_store/core/errors/custom_error.dart';
import 'package:diletta_store/core/utils/check_internet_connection.dart';
import 'package:diletta_store/layers/domain/entities/product_entity.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/filter_products_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/search_term_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/toggle_product_favorite_status_usecase.dart';
import 'package:diletta_store/layers/domain/usecases/products_usecase/get_all_products_usecase.dart';
import 'package:mobx/mobx.dart';

part 'products_controller.g.dart';

class ProductsController = _ProductsController with _$ProductsController;

abstract class _ProductsController with Store {
  late final GetAllProductsUseCase _getAllProductsUseCase;
  late final ToggleProductFavoriteStatusUseCase _toggleProductFavoriteStatus;
  late final SearchTermUseCase _searchTermUseCase;
  late final FilterProductsUseCase _filterProductsUseCase;

  _ProductsController({
    required GetAllProductsUseCase getAllProductsUseCase,
    required ToggleProductFavoriteStatusUseCase toggleProductFavoriteStatus,
    required SearchTermUseCase searchTermUseCase,
    required FilterProductsUseCase filterProductsUseCase,
  }) {
    _getAllProductsUseCase = getAllProductsUseCase;
    _toggleProductFavoriteStatus = toggleProductFavoriteStatus;
    _searchTermUseCase = searchTermUseCase;
    _filterProductsUseCase = filterProductsUseCase;
  }

  // Responsible for transmitting error messages to the UI;
  @observable
  String? errorMessage;

  // Responsible for storing the term that the user requested to search for;
  @observable
  String? searchTerm;

  // Stores all filters and orders selected by the user;
  final filters = ObservableList<FilterOption>();

  // All products based on user display requests;
  final products = ObservableList<ProductEntity>();

  /// Gets the products according to the current requirements, be it filters,
  /// searches or any other. The 'load' parameter controls whether data can be
  /// fetched from cache or must be fetched again from remote storage.
  @action
  Future<void> getProducts({bool load = false}) async {
    // Checks the user's internet connection;
    if (!await CheckInternetConnection()()) {
      return setErrorMessage(ErrorConstants.noInternet);
    }

    try {
      final allProducts = await _getAllProductsUseCase(load: load);
      List<ProductEntity> filteredProducts = allProducts;

      if (searchTerm != null) {
        filteredProducts = _searchTermUseCase(filteredProducts, searchTerm!);
      }

      filteredProducts = _filterProductsUseCase(filteredProducts, filters);

      products.clear();
      products.addAll(filteredProducts);
    } on CustomError catch (error) {
      setErrorMessage(error.message);
    } catch (_) {
      setErrorMessage(ErrorConstants.unknownError);
    }
  }

  /// Toggle the favorite status of a product.
  @action
  Future<void> toggleFavoriteStatus(ProductEntity product) async {
    await _toggleProductFavoriteStatus(product);
    await getProducts();
  }

  /// Defines a search term, so that products are filtered according to it.
  @action
  Future<void> setSearchTerm(String? term) async {
    term = term ?? "";
    searchTerm = term.isEmpty ? null : term;
    await getProducts();
  }

  /// Toggle the order of filtering through the wish list.
  @action
  Future<void> toggleFilterByWishlist() async {
    if (filters.contains(FilterOption.wishlist)) {
      filters.remove(FilterOption.wishlist);
    } else {
      filters.add(FilterOption.wishlist);
    }
    await getProducts();
  }

  /// Toggle the order of filtering by promotions.
  @action
  Future<void> toggleFilterBySale() async {
    if (filters.contains(FilterOption.onlySale)) {
      filters.remove(FilterOption.onlySale);
    } else {
      filters.add(FilterOption.onlySale);
    }
    await getProducts();
  }

  /// Activate or deactivate alphabetical ordering.
  @action
  Future<void> toggleFilterByAlphabeticalOrder(FilterOption order) async {
    // If the descending alphabetical order button was clicked;
    if (order == FilterOption.descendingAlphabetical) {
      // If the user's intention is to disable descending alphabetical order;
      if (filters.contains(FilterOption.descendingAlphabetical)) {
        filters.remove(FilterOption.descendingAlphabetical);
      }
      // If the user's intention is to activate descending alphabetical order;
      else {
        addUniqueFilter(FilterOption.descendingAlphabetical);
      }
    }

    // If the ascending alphabetical order button was clicked;
    else if (order == FilterOption.ascendingAlphabetical) {
      // If the user's intention is to disable ascending alphabetical order;
      if (filters.contains(FilterOption.ascendingAlphabetical)) {
        filters.remove(FilterOption.ascendingAlphabetical);
      }
      // If the user's intention is to activate ascending alphabetical order;
      else {
        addUniqueFilter(FilterOption.ascendingAlphabetical);
      }
    }

    // If no valid alphabetical filter option was passed;
    else {
      setErrorMessage("Filtro Inválido");
    }

    await getProducts();
  }

  /// Activate or deactivate price ordering.
  @action
  Future<void> toggleFilterByPrice(FilterOption order) async {
    // If the descending price order button was clicked.
    if (order == FilterOption.descendingPrice) {
      // If the user's intention is to disable the descending order by prices;
      if (filters.contains(FilterOption.descendingPrice)) {
        filters.remove(FilterOption.descendingPrice);
      }
      // If the user's intention is to activate the descending order by prices;
      else {
        addUniqueFilter(FilterOption.descendingPrice);
      }
    }

    // If the ascending price order button was clicked;
    else if (order == FilterOption.ascendingPrice) {
      // If the user's intention is to disable the ascending order by prices;
      if (filters.contains(FilterOption.ascendingPrice)) {
        filters.remove(FilterOption.ascendingPrice);
      }
      // If the user's intention is to activate the ascending order by prices;
      else {
        addUniqueFilter(FilterOption.ascendingPrice);
      }
    }

    // If no valid alphabetical filter option was passed;
    else {
      setErrorMessage("Filtro Inválido");
    }

    await getProducts();
  }

  /// Alphabetical order and price are unique filters, so when one is added the
  /// others are removed.
  @action
  void addUniqueFilter(FilterOption filter) {
    filters.remove(FilterOption.ascendingPrice);
    filters.remove(FilterOption.descendingPrice);
    filters.remove(FilterOption.ascendingAlphabetical);
    filters.remove(FilterOption.descendingAlphabetical);
    filters.add(filter);
  }

  /// Passes an error to the UI so that it is reported to the user.
  @action
  void setErrorMessage(String? message) {
    errorMessage = message;
  }

  /// Calculates the total quantity of products displayed.
  int productsQuantity() {
    return products.length;
  }

  /// Calculates the total price of all displayed products.
  double totalProductsPrice() {
    double total = 0.0;
    for (ProductEntity product in products) {
      total += product.price;
    }
    return total;
  }
}
