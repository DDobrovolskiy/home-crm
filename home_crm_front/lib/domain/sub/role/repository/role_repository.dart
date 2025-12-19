import 'package:home_crm_front/domain/sub/role/aggregate/role_aggregate.dart';
import 'package:home_crm_front/domain/sub/role/dto/request/role_create_dto.dart';
import 'package:home_crm_front/domain/sub/role/dto/request/role_delete_dto.dart';
import 'package:home_crm_front/domain/sub/role/dto/request/role_update_dto.dart';
import 'package:home_crm_front/domain/sub/role/dto/response/role_dto.dart';
import 'package:home_crm_front/domain/sub/role/dto/response/role_employees_dto.dart';
import 'package:home_crm_front/domain/sub/role/dto/response/role_scopes_dto.dart';

import '../../../support/port/port.dart';

class RoleRepository {
  final String _path = 'role';
  final String _pathScopes = 'role/scopes';

  Future<List<RoleAggregate>?> roles() {
    return Port.get(
      'role/all',
      (j) =>
          (j as List)
              .map((i) => RoleAggregate.fromJson(i as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Future<RoleDto?> roleCurrent() {
    return Port.get(_path, (j) => RoleDto.fromJson(j as Map<String, dynamic>));
  }

  Future<RoleDto?> role(int id) {
    return Port.get(
      'role/$id',
      (j) => RoleDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<RoleDto?> roleCreate(RoleCreateDto dto) {
    return Port.post(
      _path,
      dto.toJson(),
      (j) => RoleDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<RoleDto?> roleUpdate(RoleUpdateDto dto) {
    return Port.put(
      _path,
      dto.toJson(),
      (j) => RoleDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<int?> roleDelete(RoleDeleteDto dto) {
    return Port.delete(_path, dto.toJson(), (j) => j as int);
  }

  Future<RoleScopesDto?> roleCurrentScopes() {
    return Port.get(
      _pathScopes,
      (j) => RoleScopesDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<RoleScopesDto?> roleScopes(int id) {
    return Port.get(
      'role/$id/scopes',
      (j) => RoleScopesDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<RoleEmployeeDto?> roleEmployees(int id) {
    return Port.get(
      'role/$id/employees',
      (j) => RoleEmployeeDto.fromJson(j as Map<String, dynamic>),
    );
  }
}
