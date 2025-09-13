// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_full_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleFullDto _$RoleFullDtoFromJson(Map<String, dynamic> json) => RoleFullDto(
  role: RoleDto.fromJson(json['role'] as Map<String, dynamic>),
  employee: RoleEmployeeDto.fromJson(json['employee'] as Map<String, dynamic>),
  scopes: RoleScopesDto.fromJson(json['scopes'] as Map<String, dynamic>),
);

Map<String, dynamic> _$RoleFullDtoToJson(RoleFullDto instance) =>
    <String, dynamic>{
      'role': instance.role,
      'employee': instance.employee,
      'scopes': instance.scopes,
    };
