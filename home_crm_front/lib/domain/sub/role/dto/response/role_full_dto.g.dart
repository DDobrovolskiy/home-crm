// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_full_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleFullDto _$RoleFullDtoFromJson(Map<String, dynamic> json) => RoleFullDto(
  role: RoleDto.fromJson(json['role'] as Map<String, dynamic>),
  roleEmployee: RoleEmployeeDto.fromJson(
    json['roleEmployee'] as Map<String, dynamic>,
  ),
  roleScopes: RoleScopesDto.fromJson(
    json['roleScopes'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$RoleFullDtoToJson(RoleFullDto instance) =>
    <String, dynamic>{
      'role': instance.role,
      'roleEmployee': instance.roleEmployee,
      'roleScopes': instance.roleScopes,
    };
