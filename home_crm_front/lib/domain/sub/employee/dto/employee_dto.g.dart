// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeDto _$EmployeeDtoFromJson(Map<String, dynamic> json) => EmployeeDto(
  id: (json['id'] as num).toInt(),
  user: UserDto.fromJson(json['user'] as Map<String, dynamic>),
  organization: OrganizationDto.fromJson(
    json['organization'] as Map<String, dynamic>,
  ),
  role: RoleDto.fromJson(json['role'] as Map<String, dynamic>),
);

Map<String, dynamic> _$EmployeeDtoToJson(EmployeeDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user': instance.user,
      'organization': instance.organization,
      'role': instance.role,
    };
