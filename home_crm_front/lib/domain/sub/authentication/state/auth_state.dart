import '../../../support/exceptions/exceptions.dart';

abstract class AuthState {
  abstract final bool check;
  abstract final bool loaded;
  abstract final int? userId;
  abstract final int? organizationId;
  abstract final PortException? error;
}

class AuthNotLoginState extends AuthState {
  @override
  bool get check => false;

  @override
  bool get loaded => false;

  @override
  int? get organizationId => null;

  @override
  int? get userId => null;

  @override
  get error => null;
}

class AuthCheckState extends AuthState {
  @override
  bool get check => true;

  @override
  bool get loaded => false;

  @override
  int? get organizationId => null;

  @override
  int? get userId => null;

  @override
  get error => null;
}

class AuthProcessingState extends AuthState {
  @override
  bool get check => false;

  @override
  bool get loaded => true;

  @override
  int? get organizationId => null;

  @override
  int? get userId => null;

  @override
  get error => null;
}

class AuthLoginState extends AuthState {
  @override
  final int userId;
  @override
  final int? organizationId;

  AuthLoginState({required this.userId, required this.organizationId});

  @override
  bool get check => false;

  @override
  bool get loaded => true;

  @override
  get error => null;
}

class AuthLoginErrorState extends AuthState {
  @override
  final PortException error;

  AuthLoginErrorState({required this.error});

  @override
  bool get check => false;

  @override
  bool get loaded => false;

  @override
  int? get organizationId => null;

  @override
  int? get userId => null;
}
