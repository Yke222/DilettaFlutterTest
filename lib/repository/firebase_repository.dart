import 'dart:developer';

import 'package:diletta_flutter_test/repository/user_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository implements UserRepository {
  FirebaseRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;
  @override
  Future<void> sigIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> sigUp(String email, String password) {
    // TODO: implement sigUp
    throw UnimplementedError();
  }

  @override
  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Stream<User?> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser;
      log('user: $user');
      return user;
    });
  }
}
