class AppState {
  final String? authToken;
  RegistrationState registration = RegistrationState();

  AppState(this.authToken);

  bool isLogged() {
    return authToken != null;
  }
}

class RegistrationState {
  bool load = false;
}
