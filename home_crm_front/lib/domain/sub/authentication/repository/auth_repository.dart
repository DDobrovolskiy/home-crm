import 'package:home_crm_front/domain/sub/authentication/dto/simple_auth_dto.dart';

import '../../../support/port/port.dart';
import '../dto/simple_login_dto.dart';

class AuthRepository {
  final String _path = 'auth';
  final String _pathLogin = 'auth/login';
  final String _pathRegistration = 'auth/registration';

  Future<String?> login(SimpleLoginDto dto) {
    return Port.post(_pathLogin, dto.toJson(), (j) => j as String);
  }

  Future<String?> registartion(SimpleAuthDto dto) {
    return Port.post(_pathRegistration, dto.toJson(), (j) => j as String);
  }
}
