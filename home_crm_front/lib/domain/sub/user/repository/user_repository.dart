import 'package:home_crm_front/domain/sub/user/dto/user_employee_dto.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_organization_dto.dart';

import '../../../support/port/port.dart';
import '../dto/user_dto.dart';

class UserRepository {
  final String _path = 'user';
  final String _path_organization = 'user/organization';
  final String _path_employee = 'user/employee';

  Future<UserDto?> userFromLocalStorage() {
    return user();
  }

  Future<UserDto?> user() {
    return Port.get(_path, (j) => UserDto.fromJson(j as Map<String, dynamic>));
  }

  Future<UserOrganizationDto?> organization() {
    return Port.get(
      _path_organization,
      (j) => UserOrganizationDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<UserEmployeeDto?> employee() {
    return Port.get(
      _path_employee,
      (j) => UserEmployeeDto.fromJson(j as Map<String, dynamic>),
    );
  }
}
