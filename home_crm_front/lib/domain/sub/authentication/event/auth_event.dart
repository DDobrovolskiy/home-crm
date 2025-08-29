abstract class AuthEvent {}

class AuthInitEvent extends AuthEvent {}

class AuthLoginEvent extends AuthEvent {
  final String phone;
  final String password;

  AuthLoginEvent({required this.phone, required this.password});
}

class AuthRegistrationEvent extends AuthEvent {
  final String name;
  final String phone;
  final String password;

  AuthRegistrationEvent({
    required this.name,
    required this.phone,
    required this.password,
  });
}
