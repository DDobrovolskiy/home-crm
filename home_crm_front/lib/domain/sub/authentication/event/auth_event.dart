import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

abstract class AuthEvent {}

class AuthCheckEvent extends AuthEvent {}

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

class AuthLogoutEvent extends AuthEvent {}

class AuthLogoutAllEvent extends AuthEvent {}

class AuthErrorEvent extends AuthEvent {
  final PortException error;

  AuthErrorEvent({required this.error});
}
