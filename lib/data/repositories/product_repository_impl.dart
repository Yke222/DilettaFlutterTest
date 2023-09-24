import 'package:ecommerce/data/datasources/remote_datasource.dart';
import 'package:ecommerce/data/models/product.dart';
import 'package:ecommerce/domain/product_repository.dart';
import 'package:ecommerce/utils.dart';
import 'package:result_dart/result_dart.dart';

class ProductRepositoryImpl extends ProductRepository {
  final RemoteDataSource dataSource;

  ProductRepositoryImpl({required this.dataSource});

  @override
  Future<Result<List<Product>, Exception>> getProducts({
    String term = '',
    int from = 0,
    int to = 19,
    FilterMode filter = FilterMode.none,
  }) async {
    try {
      final result = await dataSource.getProducts(term: term, from: from, to: to, filterMode: filter);
      return Result.success(result);
    } catch (e) {
      return Result.failure(Exception(e.toString()));
    }
  }
}
