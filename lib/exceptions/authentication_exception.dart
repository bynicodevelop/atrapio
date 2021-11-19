class AuthenticationException implements Exception {
  static const String emailAlreadyExists = "emailAlreadyExists";
  static const String invalidEmail = "invalidEmail";
  static const String invalidPassword = "invalidPassword";
  static const String badCredentials = "badCredentials";

  final String message;

  const AuthenticationException(
    this.message,
  );

  @override
  String toString() {
    return message;
  }
}
