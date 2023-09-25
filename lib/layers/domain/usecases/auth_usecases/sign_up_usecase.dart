import 'package:diletta_store/core/constants/error_constants.dart';
import 'package:diletta_store/core/errors/custom_error.dart';
import 'package:diletta_store/layers/domain/repositories/auth_repository.dart';

/// Orders and handles the creation of a user account.
class SignUpUseCase {
  final AuthRepository _authRepository;

  SignUpUseCase(this._authRepository);

  Future<bool> call(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      throw CustomError(ErrorConstants.incompleteInformation);
    }

    await _authRepository.signUp(email, password);
    return true;
  }
}
