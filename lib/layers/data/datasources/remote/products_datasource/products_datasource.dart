import 'package:diletta_store/layers/data/dtos/product_dto.dart';

abstract class ProductsDataSource {
  /// Get all available products from cloud storage.
  Future<List<ProductDTO>> getAvailableProducts();
}