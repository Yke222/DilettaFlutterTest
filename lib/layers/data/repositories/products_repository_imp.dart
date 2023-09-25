import 'package:diletta_store/layers/data/datasources/local/wishlist_datasource/wishlist_datasource.dart';
import 'package:diletta_store/layers/data/datasources/remote/products_datasource/products_datasource.dart';
import 'package:diletta_store/layers/data/dtos/product_dto.dart';
import 'package:diletta_store/layers/domain/entities/product_entity.dart';
import 'package:diletta_store/layers/domain/repositories/products_repository.dart';

class ProductsRepositoryImp implements ProductsRepository {
  late final ProductsDataSource _productsDataSource;
  late final WishlistDataSource _wishlistDataSource;

  ProductsRepositoryImp({
    required ProductsDataSource productsDataSource,
    required WishlistDataSource wishlistDataSource,
  }) {
    _productsDataSource = productsDataSource;
    _wishlistDataSource = wishlistDataSource;
  }

  // Products are obtained once and stored for the duration of the current
  // session unless new data is ordered to be obtained;
  final List<ProductDTO> _products = [];

  @override
  Future<List<ProductEntity>> getAllProducts({bool load = false}) async {
    // If it is the first consultation or an order for a new consultation;
    if (_products.isEmpty || load) await loadAllProducts();

    // Otherwise returns the products already obtained previously;
    return _products;
  }

  @override
  Future<bool> addProductToWishList(int id) async {
    // Adds favorite status to the product in the already loaded list;
    _products.firstWhere((product) => product.id == id).isFavorite = true;

    return await _wishlistDataSource.addProductToWishList(id);
  }

  @override
  Future<bool> removeProductFromWishList(int id) async {
    // Removes the favorite status of the product in the already loaded list;
    _products.firstWhere((product) => product.id == id).isFavorite = false;

    return await _wishlistDataSource.removeProductFromWishList(id);
  }

  @override
  Future<bool> clearWishlist() async {
    return await _wishlistDataSource.clearData();
  }

  /// Reload all products from remote storage.
  Future<void> loadAllProducts() async {
    final availableProducts = await _productsDataSource.getAvailableProducts();

    final wishlist = await _wishlistDataSource.getWishlist();

    for (ProductDTO product in availableProducts) {
      // If the product id is in the wish list it will be marked as favorite.
      product.isFavorite = wishlist.contains(product.id);
    }

    _products.clear();
    _products.addAll(availableProducts);
  }
}
