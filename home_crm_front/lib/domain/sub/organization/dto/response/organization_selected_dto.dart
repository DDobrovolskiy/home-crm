import 'package:home_crm_front/domain/sub/role/dto/response/role_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import 'organization_dto.dart';

part 'organization_selected_dto.g.dart';

@JsonSerializable()
class OrganizationSelectedDto {
  final OrganizationDto organization;
  final RoleDto role;

  OrganizationSelectedDto({required this.organization, required this.role});

  Map<String, dynamic> toJson() {
    return _$OrganizationSelectedDtoToJson(this);
  }

  factory OrganizationSelectedDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationSelectedDtoFromJson(json);
}
