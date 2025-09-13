import 'package:home_crm_front/domain/sub/role/dto/response/role_dto.dart';
import 'package:home_crm_front/domain/sub/role/dto/response/role_employees_dto.dart';
import 'package:home_crm_front/domain/sub/role/dto/response/role_scopes_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'role_full_dto.g.dart';

@JsonSerializable()
class RoleFullDto {
  final RoleDto role;
  final RoleEmployeeDto roleEmployee;
  final RoleScopesDto roleScopes;

  RoleFullDto({
    required this.role,
    required this.roleEmployee,
    required this.roleScopes,
  });

  Map<String, dynamic> toJson() {
    return _$RoleFullDtoToJson(this);
  }

  factory RoleFullDto.fromJson(Map<String, dynamic> json) =>
      _$RoleFullDtoFromJson(json);
}
