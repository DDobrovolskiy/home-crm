class AuthException implements Exception {}

class PortException implements Exception {
  final String message;
  final bool auth;

  PortException({required this.message, required this.auth});
}

class ResponseException implements Exception {
  final String message;

  ResponseException({required this.message});
}
