abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthProcessingState extends AuthState {}

class AuthSuccessState extends AuthState {}

class AuthLoginErrorState extends AuthState {
  final String message;

  AuthLoginErrorState({required this.message});
}
