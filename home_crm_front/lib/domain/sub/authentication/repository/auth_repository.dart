import 'package:home_crm_front/domain/sub/authentication/dto/request/simple_auth_dto.dart';

import '../../../support/port/port.dart';
import '../dto/request/simple_login_dto.dart';
import '../dto/response/auth_response_dto.dart';

class AuthRepository {
  final String _pathLogin = 'auth/login';
  final String _pathLoginToken = 'auth/login/token';
  final String _pathLogout = 'auth/logout';
  final String _pathRegistration = 'auth/registration';

  Future<AuthResponseDto?> login(SimpleLoginDto dto) {
    return Port.post(_pathLogin, dto.toJson(), (j) =>
        AuthResponseDto.fromJson(j as Map<String, dynamic>));
  }

  Future<AuthResponseDto?> loginToken() {
    return Port.get(_pathLoginToken, (j) =>
        AuthResponseDto.fromJson(j as Map<String, dynamic>));
  }

  Future<AuthResponseDto?> registartion(SimpleAuthDto dto) {
    return Port.post(_pathRegistration, dto.toJson(), (j) =>
        AuthResponseDto.fromJson(j as Map<String, dynamic>));
  }

  Future<bool?> logout() {
    return Port.post(_pathLogout, {}, (j) => j as bool);
  }
}
