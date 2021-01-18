class HtmlException implements Exception {
  const HtmlException(this.message);
  final String message;
  @override
  String toString() => message;
}
