import 'package:atrap_io/exceptions/authentication_exception.dart';
import 'package:atrap_io/repositories/authentication_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mocks/firebase_auth_mock.dart';
import '../mocks/user_credential_mock.dart';

void main() {
  late FirebaseAuthMock mockFirebaseAuth;
  late AuthenticationRepository authenticationRepository;

  group("Test signUpWithEmailAndPassword method", () {
    setUp(() {
      mockFirebaseAuth = FirebaseAuthMock();

      authenticationRepository = AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );
    });

    test("Should signup user with success", () async {
      // ARRAGE
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "john@domain.tld",
        password: "123456",
      )).thenAnswer((_) => Future.value(UserCredentialMock()));

      // ACT
      // ASSERT
      expect(
        () async => await authenticationRepository.signUpWithEmailAndPassword(
          email: "john@domain.tld",
          password: "123456",
        ),
        returnsNormally,
      );
    });

    test("Should expect an exception when email already exists", () async {
      // ARRANGE
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "john@domain.tld",
        password: "123456",
      )).thenThrow(
        FirebaseAuthException(
          code: "email-already-in-use",
        ),
      );

      authenticationRepository = AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // ACT
      // ASSERT
      expect(
        () async => await authenticationRepository.signUpWithEmailAndPassword(
          email: "john@domain.tld",
          password: "123456",
        ),
        throwsA(
          predicate(
            (e) =>
                e is AuthenticationException &&
                e.message == AuthenticationException.emailAlreadyExists,
          ),
        ),
      );
    });

    test("Should expect an exception when email is invalid", () async {
      // ARRANGE
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "john@domain.tld",
        password: "123456",
      )).thenThrow(
        FirebaseAuthException(
          code: "invalid-email",
        ),
      );

      authenticationRepository = AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // AC
      // ASSERT
      expect(
        () => authenticationRepository.signUpWithEmailAndPassword(
          email: "john@domain.tld",
          password: "123456",
        ),
        throwsA(
          predicate(
            (e) =>
                e is AuthenticationException &&
                e.message == AuthenticationException.invalidEmail,
          ),
        ),
      );
    });

    test("Should expect an exception when password is invalid", () async {
      // ARRANGE
      when(mockFirebaseAuth.createUserWithEmailAndPassword(
        email: "john@domain.tld",
        password: "123456",
      )).thenThrow(
        FirebaseAuthException(
          code: "weak-password",
        ),
      );

      authenticationRepository = AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // AC
      // ASSERT
      expect(
        () => authenticationRepository.signUpWithEmailAndPassword(
          email: "john@domain.tld",
          password: "123456",
        ),
        throwsA(
          predicate(
            (e) =>
                e is AuthenticationException &&
                e.message == AuthenticationException.invalidPassword,
          ),
        ),
      );
    });
  });

  group("Test signUpWithEmailAndPassword method", () {
    setUp(() {
      mockFirebaseAuth = FirebaseAuthMock();

      authenticationRepository = AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );
    });

    test("Should signin with success", () async {
      // ARRANGE
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: "john@domain.tld",
        password: "123456",
      )).thenAnswer((_) => Future.value(UserCredentialMock()));

      AuthenticationRepository authenticationRepository =
          AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // ACT
      // ASSERT
      expect(
        () async => await authenticationRepository.signInWithEmailAndPassword(
          email: "john@domain.tld",
          password: "123456",
        ),
        returnsNormally,
      );
    });

    test("Should signin with wrong email", () async {
      // ARRANGE
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: "john@domain.tld",
        password: "123456",
      )).thenThrow(
        FirebaseAuthException(
          code: "user-not-found",
        ),
      );

      AuthenticationRepository authenticationRepository =
          AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // ACT
      // ASSERT
      expect(
        () async => await authenticationRepository.signInWithEmailAndPassword(
          email: "john@domain.tld",
          password: "123456",
        ),
        throwsA(
          predicate(
            (e) =>
                e is AuthenticationException &&
                e.message == AuthenticationException.badCredentials,
          ),
        ),
      );
    });

    test("Should signin with wrong email and password", () async {
      // ARRANGE
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: "john@domain.tld",
        password: "123456",
      )).thenThrow(
        FirebaseAuthException(
          code: "wrong-password",
        ),
      );

      AuthenticationRepository authenticationRepository =
          AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // ACT
      // ASSERT
      expect(
        () async => await authenticationRepository.signInWithEmailAndPassword(
          email: "john@domain.tld",
          password: "123456",
        ),
        throwsA(
          predicate(
            (e) =>
                e is AuthenticationException &&
                e.message == AuthenticationException.badCredentials,
          ),
        ),
      );
    });

    test("Should signin with invalid email", () async {
      // ARRANGE
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: "john@domain.tld",
        password: "123456",
      )).thenThrow(
        FirebaseAuthException(
          code: "invalid-email",
        ),
      );

      AuthenticationRepository authenticationRepository =
          AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // ACT
      // ASSERT
      expect(
        () async => await authenticationRepository.signInWithEmailAndPassword(
          email: "john@domain.tld",
          password: "123456",
        ),
        throwsA(
          predicate(
            (e) =>
                e is AuthenticationException &&
                e.message == AuthenticationException.invalidEmail,
          ),
        ),
      );
    });

    test("Should signin with disabled user", () async {
      // ARRANGE
      when(mockFirebaseAuth.signInWithEmailAndPassword(
        email: "john@domain.tld",
        password: "123456",
      )).thenThrow(
        FirebaseAuthException(
          code: "user-disabled",
        ),
      );

      AuthenticationRepository authenticationRepository =
          AuthenticationRepository(
        firebaseAuth: mockFirebaseAuth,
      );

      // ACT
      // ASSERT
      expect(
        () async => await authenticationRepository.signInWithEmailAndPassword(
          email: "john@domain.tld",
          password: "123456",
        ),
        throwsA(
          predicate(
            (e) =>
                e is AuthenticationException &&
                e.message == AuthenticationException.badCredentials,
          ),
        ),
      );
    });
  });
}
