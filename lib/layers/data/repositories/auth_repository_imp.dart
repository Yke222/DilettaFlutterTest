import 'package:diletta_store/layers/data/datasources/remote/auth_datasource/auth_datasource.dart';
import 'package:diletta_store/layers/domain/entities/user_entity.dart';
import 'package:diletta_store/layers/domain/repositories/auth_repository.dart';

class AuthRepositoryImp implements AuthRepository {
  late final AuthDataSource _authDataSource;

  AuthRepositoryImp({
    required AuthDataSource authDataSource,
  }) {
    _authDataSource = authDataSource;
  }

  @override
  Future<void> signIn(String email, String password) async {
    await _authDataSource.signIn(email, password);
  }

  @override
  Future<void> signUp(String email, String password) async {
    await _authDataSource.signUp(email, password);
  }

  @override
  Future<void> signOut() async {
    await _authDataSource.signOut();
  }

  @override
  UserEntity? getUser() {
    return _authDataSource.getUser();
  }
}
