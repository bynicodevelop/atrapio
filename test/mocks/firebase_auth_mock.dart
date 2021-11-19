import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockito/mockito.dart';

import 'user_credential_mock.dart';

class FirebaseAuthMock extends Mock implements FirebaseAuth {
  @override
  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      super.noSuchMethod(
        Invocation.method(#createUserWithEmailAndPassword, [email, password]),
        returnValueForMissingStub: Future.value(UserCredentialMock()),
        returnValue: Future.value(UserCredentialMock()),
      );

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async =>
      super.noSuchMethod(
        Invocation.method(#signInWithEmailAndPassword, [email, password]),
        returnValueForMissingStub: Future.value(UserCredentialMock()),
        returnValue: Future.value(UserCredentialMock()),
      );
}
