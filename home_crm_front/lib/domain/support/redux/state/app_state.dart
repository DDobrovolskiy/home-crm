import '../../../sub/user/store/user_state.dart';

class AppState {
  String? authToken;
  AuthState authState = AuthState();
  UserState? userState;

  AppState(this.authToken);

  bool isLogged() {
    return authToken != null;
  }
}

class AuthState {
  RegistrationState registrationState = RegistrationState();
  LoginState loginState = LoginState();
}

class RegistrationState {
  bool load = false;
  String? messageError;
}

class LoginState {
  bool load = false;
  String? messageError;
}

