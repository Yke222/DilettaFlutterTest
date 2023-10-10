import 'package:shample_app/src/data/datasources/remote/product/dio_product.dart';
import 'package:shample_app/src/domain/models/product.dart';

class ProductsRepository {
  Future<List<Product>> getProducts() {
    return DioProduct().getData();
  }
}
