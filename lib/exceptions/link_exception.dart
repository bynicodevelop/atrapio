class LinkException implements Exception {
  static const String userIdRequired = "userIdRequired";
  static const String urlIsRequired = "urlIsRequired";
  static const String linkIdIsRequired = "linkIdIsRequired";
  static const String createdAtIsRequired = "createdAtIsRequired";

  final String message;

  const LinkException(this.message);
}
