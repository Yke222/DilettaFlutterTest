import 'package:ecommerce/data/models/product.dart';
import 'package:ecommerce/utils.dart';
import 'package:result_dart/result_dart.dart';

abstract class ProductRepository {
  Future<Result<List<Product>, Exception>> getProducts({
    String term = '',
    int from = 0,
    int to = 19,
    FilterMode filter = FilterMode.none,
  });
}
