import 'package:diletta_flutter_test/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {

  Future<void> sigIn(String email, String password);

  Future<void> logOut();

  Future<void> sigUp(final UserModel user, String password);

  Stream<User?> get user;

}