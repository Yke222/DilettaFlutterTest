import 'package:diletta_store/core/errors/custom_error.dart';
import 'package:diletta_store/layers/data/datasources/remote/auth_datasource/auth_datasource.dart';
import 'package:diletta_store/layers/data/dtos/user_dto.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthDataSourceImp implements AuthDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (authError) {
      if (authError.code == "email-already-in-use") {
        throw CustomError("O Email fornecido já está em uso");
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  UserDTO? getUser() {
    if (_auth.currentUser == null) return null;
    return UserDTO(
      uid: _auth.currentUser!.uid,
      email: _auth.currentUser!.email!,
      displayName: _auth.currentUser!.displayName,
    );
  }
}
