class LinkException implements Exception {
  static const String userIdRequired = "userIdRequired";
  static const String urlIsRequired = "urlIsRequired";
  static const String linkIdIsRequired = "linkIdIsRequired";

  final String message;

  LinkException(this.message);
}
