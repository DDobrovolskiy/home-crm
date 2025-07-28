class AppState {
  final String? authToken;

  const AppState({
    required this.authToken,
  });

  bool isLogged() {
    return authToken != null;
  }
}
