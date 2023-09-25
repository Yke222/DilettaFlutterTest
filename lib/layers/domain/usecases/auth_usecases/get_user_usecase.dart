import 'package:diletta_store/layers/domain/entities/user_entity.dart';
import 'package:diletta_store/layers/domain/repositories/auth_repository.dart';

/// Orders to obtain current user data.
class GetUserUseCase {
  final AuthRepository _authRepository;

  GetUserUseCase(this._authRepository);

  UserEntity? call() {
    return _authRepository.getUser();
  }
}