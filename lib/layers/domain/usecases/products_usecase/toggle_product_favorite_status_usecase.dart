import 'package:diletta_store/core/errors/custom_error.dart';
import 'package:diletta_store/layers/domain/entities/product_entity.dart';
import 'package:diletta_store/layers/domain/repositories/products_repository.dart';

/// Orders a product to be added or removed from the wish list.
class ToggleProductFavoriteStatusUseCase {
  final ProductsRepository _productsRepository;

  ToggleProductFavoriteStatusUseCase(this._productsRepository);

  Future<bool> call(ProductEntity product) async {
    if (product.isFavorite) {
      try {
        return await _productsRepository.removeProductFromWishList(product.id);
      } catch (_) {
        throw CustomError("Erro ao remover produto da Lista de Desejos");
      }
    } else {
      try {
        return await _productsRepository.addProductToWishList(product.id);
      } catch (_) {
        throw CustomError("Erro ao adicionar produto à Lista de Desejos");
      }
    }
  }
}
