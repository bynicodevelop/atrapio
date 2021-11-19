import 'package:atrap_io/exceptions/authentication_exception.dart';
import 'package:atrap_io/models/user_model.dart';

import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationRepository {
  final FirebaseAuth firebaseAuth;

  const AuthenticationRepository({
    required this.firebaseAuth,
  });

  String get userId => firebaseAuth.currentUser!.uid;

  Stream<UserModel> get user {
    return firebaseAuth.authStateChanges().map((user) {
      if (user == null) {
        return UserModel.empty;
      }

      return UserModel.fromJson({
        'uid': user.uid,
        'email': user.email,
      });
    });
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String code = AuthenticationException.emailAlreadyExists;

      switch (e.code) {
        case "invalid-email":
          code = AuthenticationException.invalidEmail;
          break;
        case "weak-password":
          code = AuthenticationException.invalidPassword;
          break;
      }

      throw AuthenticationException(code);
    }
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      String code = AuthenticationException.invalidEmail;

      switch (e.code) {
        case "user-disabled":
        case "user-not-found":
        case "wrong-password":
          code = AuthenticationException.badCredentials;
          break;
      }

      throw AuthenticationException(code);
    }
  }

  Future<void> signOut() async => await firebaseAuth.signOut();
}
