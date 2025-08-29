class AuthException implements Exception {}

class PortException implements Exception {}

class ResponseException implements Exception {
  final String message;

  ResponseException({required this.message});
}
