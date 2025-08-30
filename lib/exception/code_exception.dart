class CodeException implements Exception {
  const CodeException(this.message);

  final String message;

  @override
  String toString() => message;
}
