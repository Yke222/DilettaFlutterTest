import 'package:ecommerce/data/models/product.dart';
import 'package:result_dart/result_dart.dart';

abstract class WishlistRepository {
  Future<Result<bool, Exception>> addToWishlist({required Product product});
  Future<Result<bool, Exception>> removeFromWishlist({required Product product});
  Future<Result<List<Product>, Exception>> getWishlist();
}
