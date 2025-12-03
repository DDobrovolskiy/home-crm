// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_selected_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationSelectedDto _$OrganizationSelectedDtoFromJson(
  Map<String, dynamic> json,
) => OrganizationSelectedDto(
  organization: OrganizationDto.fromJson(
    json['organization'] as Map<String, dynamic>,
  ),
  role: RoleDto.fromJson(json['role'] as Map<String, dynamic>),
);

Map<String, dynamic> _$OrganizationSelectedDtoToJson(
  OrganizationSelectedDto instance,
) => <String, dynamic>{
  'organization': instance.organization,
  'role': instance.role,
};
