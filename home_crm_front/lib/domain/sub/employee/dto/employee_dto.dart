import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:home_crm_front/domain/sub/role/dto/role_dto.dart';
import 'package:home_crm_front/domain/sub/user/dto/user_base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../support/port/base_dto.dart';
import '../../../support/port/error_data_dto.dart';

part 'employee_dto.g.dart';

@JsonSerializable()
class EmployeeDto {
  final int id;
  final UserBaseDto user;
  final OrganizationDto organization;
  final RoleDto role;

  EmployeeDto({
    required this.id,
    required this.user,
    required this.organization,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return _$EmployeeDtoToJson(this);
  }

  factory EmployeeDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeDtoFromJson(json);
}
