import 'package:ecommerce/data/datasources/local_datasource.dart';
import 'package:ecommerce/data/models/product.dart';
import 'package:ecommerce/domain/cart_repository.dart';
import 'package:result_dart/result_dart.dart';

class CartRepositoryImpl extends CartRepository {
  final LocalDataSource dataSource;

  CartRepositoryImpl({required this.dataSource});

  @override
  Future<Result<bool, Exception>> addToCart({required Product product}) async {
    try {
      final result = await dataSource.addProductTo(product: product);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<List<Product>, Exception>> getCart() async {
    try {
      final result = await dataSource.getProductFrom();
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }

  @override
  Future<Result<bool, Exception>> removeFromCart({required Product product}) async {
    try {
      final result = await dataSource.removeProductFrom(product: product);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }
}
