// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeCreateDto _$EmployeeCreateDtoFromJson(Map<String, dynamic> json) =>
    EmployeeCreateDto(
      name: json['name'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
      roleId: (json['roleId'] as num).toInt(),
    );

Map<String, dynamic> _$EmployeeCreateDtoToJson(EmployeeCreateDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
      'roleId': instance.roleId,
    };
