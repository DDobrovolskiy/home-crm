// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_role_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationRoleDto _$OrganizationRoleDtoFromJson(Map<String, dynamic> json) =>
    OrganizationRoleDto(
      roles: (json['roles'] as List<dynamic>)
          .map((e) => RoleFullDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrganizationRoleDtoToJson(
  OrganizationRoleDto instance,
) => <String, dynamic>{'roles': instance.roles};
