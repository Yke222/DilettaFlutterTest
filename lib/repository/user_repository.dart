import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {

  Future<void> sigIn(String email, String password);

  Future<void> logOut();

  Future<void> sigUp(String email, String password);

  Stream<User?> get user;

}