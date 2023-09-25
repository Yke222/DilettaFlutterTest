import 'package:diletta_store/core/errors/custom_error.dart';
import 'package:diletta_store/layers/domain/repositories/auth_repository.dart';
import 'package:diletta_store/layers/domain/repositories/products_repository.dart';

/// Orders and handles a user's logout.
class SignOutUseCase {
  final AuthRepository _authRepository;
  final ProductsRepository _productsRepository;

  SignOutUseCase(this._authRepository, this._productsRepository);

  Future<bool> call() async {
    try {
      await _productsRepository.clearWishlist();
      await _authRepository.signOut();
      return true;
    } catch (_) {
      throw CustomError("Erro ao sair da Conta");
    }
  }
}