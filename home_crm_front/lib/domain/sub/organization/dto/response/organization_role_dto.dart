import 'package:home_crm_front/domain/sub/role/dto/response/role_full_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_role_dto.g.dart';

@JsonSerializable()
class OrganizationRoleDto {
  final List<RoleFullDto> roles;

  OrganizationRoleDto({required this.roles});

  Map<String, dynamic> toJson() {
    return _$OrganizationRoleDtoToJson(this);
  }

  factory OrganizationRoleDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationRoleDtoFromJson(json);
}
