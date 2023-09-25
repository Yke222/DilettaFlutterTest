import 'package:diletta_store/layers/domain/entities/user_entity.dart';

abstract class AuthRepository {
  /// Forwards the user's final credentials for login.
  Future<void> signIn(String email, String password);

  /// Forwards the user's final credentials for registration.
  Future<void> signUp(String email, String password);

  /// Forwards the request to log out of the current account.
  Future<void> signOut();

  /// If the user is logged in, it obtains their data, otherwise it returns null.
  UserEntity? getUser();
}
