class AppState {
  final String username;
  final String? authToken;
  final bool isLoggedIn;

  const AppState({
    required this.username,
    required this.isLoggedIn,
    required this.authToken,
  });

  bool isLogged() {
    return authToken != null;
  }
}
