import 'package:ecommerce/data/datasources/local_datasource.dart';
import 'package:ecommerce/data/models/product.dart';
import 'package:ecommerce/domain/wishlist_repository.dart';
import 'package:result_dart/result_dart.dart';

class WishlistRepositoryImpl extends WishlistRepository {
  final LocalDataSource dataSource;

  WishlistRepositoryImpl({required this.dataSource});

  @override
  Future<Result<bool, Exception>> addToWishlist({required Product product}) async {
    try {
      final result = await dataSource.addProductTo(product: product, fromCart: false);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Product>, Exception>> getWishlist() async {
    try {
      final result = await dataSource.getProductFrom(fromCart: false);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<bool, Exception>> removeFromWishlist({required Product product}) async {
    try {
      final result = await dataSource.removeProductFrom(product: product, fromCart: false);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }
}
