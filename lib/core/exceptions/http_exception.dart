// ignore_for_file: public_member_api_docs, sort_constructors_first
class HTTPException implements Exception {
  final String message;
  final int statusCode;

  HTTPException({
    required this.message,
    required this.statusCode,
  });

  @override
  String toString() => message;
}
