import 'package:diletta_store/layers/domain/entities/product_entity.dart';

abstract class ProductsRepository {
  /// Get all available products, from cache or from cloud.
  Future<List<ProductEntity>> getAllProducts({bool load = false});

  /// Forwards and handles the request to add a user to the wish list.
  Future<bool> addProductToWishList(int id);

  /// Forwards and handles the request to remove a user from the wish list.
  Future<bool> removeProductFromWishList(int id);

  /// Forwards and handles the request to log out of the currently logged in account.
  Future<bool> clearWishlist();
}