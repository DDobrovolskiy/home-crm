import 'package:home_crm_front/domain/sub/organization/dto/request/organization_create_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_delete_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/request/organization_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_employee_dto.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_organization_dto.dart';
import 'package:http/http.dart';

import '../../../support/port/port.dart';

class OrganizationRepository {
  final String _path = 'organization';

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
    return Port.post(
      _path,
      dto.toJson(),
      (j) => OrganizationDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<String?> organizationDelete(OrganizationDeleteDto dto) {
    return Port.post(_path, dto.toJson(), (j) => j as String);
  }
}
