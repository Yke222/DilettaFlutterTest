import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diletta_flutter_test/data/repository/user_repository.dart';
import 'package:diletta_flutter_test/domain/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRepository implements UserRepository {
  FirebaseRepository({FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;
  final FirebaseAuth _firebaseAuth;
  final usersCollection = FirebaseFirestore.instance.collection('users');

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
  Future<void> sigUp(final UserModel user, String password) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: user.email,
        password: password,
      );
      _setUserData(user);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
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

  Future<void> _setUserData(UserModel user) async {
    try {
      await usersCollection.doc(user.id).set(UserModel.toMapJson(user));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
