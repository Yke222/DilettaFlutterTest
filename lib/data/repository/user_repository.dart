import 'package:firebase_auth/firebase_auth.dart';

import '../../domain/models/user_model.dart';

abstract class UserRepository {

  Future<void> sigIn(String email, String password);

  Future<void> logOut();

  Future<void> sigUp(final UserModel user, String password);

  Stream<User?> get user;

}