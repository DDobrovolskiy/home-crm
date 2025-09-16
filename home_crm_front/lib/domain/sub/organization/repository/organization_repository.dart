import 'package:home_crm_front/domain/sub/organization/dto/request/organization_create_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_delete_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_employee_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_employee_test_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_role_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_test_dto.dart';

import '../../../support/port/port.dart';

class OrganizationRepository {
  final String _path = 'organization';
  final String _pathEmployee = 'organization/employee';
  final String _pathRole = 'organization/role';
  final String _pathTest = 'organization/tests';
  final String _pathEmployeeTest = 'organization/employee/test';

  Future<OrganizationDto?> organizationFromLocalStorage() {
    return Port.get(
      _path,
      (j) => OrganizationDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<OrganizationDto?> organization() {
    return Port.get(
      _path,
      (j) => OrganizationDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<OrganizationDto?> organizationCreate(OrganizationCreateDto dto) {
    return Port.post(
      _path,
      dto.toJson(),
      (j) => OrganizationDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<OrganizationDto?> organizationUpdate(OrganizationUpdateDto dto) {
    return Port.put(
      _path,
      dto.toJson(),
      (j) => OrganizationDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<int?> organizationDelete(OrganizationDeleteDto dto) {
    return Port.delete(_path, dto.toJson(), (j) => j as int);
  }

  Future<OrganizationEmployeeDto?> organizationEmployee() {
    return Port.get(
      _pathEmployee,
      (j) => OrganizationEmployeeDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<OrganizationRoleDto?> organizationRole() {
    return Port.get(
      _pathRole,
      (j) => OrganizationRoleDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<OrganizationTestDto?> organizationTest() {
    return Port.get(
      _pathTest,
      (j) => OrganizationTestDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<OrganizationEmployeeTestDto?> organizationEmployeeTest() {
    return Port.get(
      _pathEmployeeTest,
      (j) => OrganizationEmployeeTestDto.fromJson(j as Map<String, dynamic>),
    );
  }
}