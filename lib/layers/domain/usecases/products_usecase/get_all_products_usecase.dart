import 'package:diletta_store/core/errors/custom_error.dart';
import 'package:diletta_store/layers/domain/entities/product_entity.dart';
import 'package:diletta_store/layers/domain/repositories/products_repository.dart';

/// Gets and processes the list of products.
class GetAllProductsUseCase {
  final ProductsRepository _productsRepository;

  GetAllProductsUseCase(this._productsRepository);

  Future<List<ProductEntity>> call({bool load = false}) async {
    try {
      final products = await _productsRepository.getAllProducts(load: load);
      return products.toList();
    } catch (_) {
      throw CustomError("Erro ao carregar produtos");
    }
  }
}
