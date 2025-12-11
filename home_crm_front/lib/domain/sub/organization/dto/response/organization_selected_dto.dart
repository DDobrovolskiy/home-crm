import 'package:home_crm_front/domain/sub/role/dto/response/role_dto.dart';
import 'package:home_crm_front/domain/sub/scope/scope.dart';
import 'package:json_annotation/json_annotation.dart';

import 'organization_dto.dart';

part 'organization_selected_dto.g.dart';

@JsonSerializable()
class OrganizationSelectedDto {
  final OrganizationDto organization;
  final RoleDto role;
  Set<String> scopes = {};

  OrganizationSelectedDto({required this.organization, required this.role}) {
    scopes = role.scopes.map((s) {
      return s.name;
    }).toSet();
  }

  bool include(ScopeType scope) {
    return scopes.contains(scope.name);
  }

  Map<String, dynamic> toJson() {
    return _$OrganizationSelectedDtoToJson(this);
  }

  factory OrganizationSelectedDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationSelectedDtoFromJson(json);
}
