abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthProcessingState extends AuthState {}

class AuthLoginState extends AuthState {}

class AuthLogoutState extends AuthState {}

class AuthLoginErrorState extends AuthState {
  final String message;

  AuthLoginErrorState({required this.message});
}
