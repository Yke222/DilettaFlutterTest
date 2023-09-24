import 'package:ecommerce/data/models/product.dart';
import 'package:result_dart/result_dart.dart';

abstract class CartRepository {
  Future<Result<bool, Exception>> addToCart({required Product product});
  Future<Result<bool, Exception>> removeFromCart({required Product product});
  Future<Result<List<Product>, Exception>> getCart();
}
