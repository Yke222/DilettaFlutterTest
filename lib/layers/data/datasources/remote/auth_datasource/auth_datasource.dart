import 'package:diletta_store/layers/data/dtos/user_dto.dart';

abstract class AuthDataSource {
  /// Log in, with email and password, to the account of an existing user.
  Future<void> signIn(String email, String password);

  /// Try to create, with email and password, a new account.
  Future<void> signUp(String email, String password);

  /// Log out of the currently logged in account.
  Future<void> signOut();

  /// Gets the data of the currently logged in user.
  /// If the user is not logged in, returns null.
  UserDTO? getUser();
}