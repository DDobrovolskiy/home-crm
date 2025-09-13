// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_employees_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleEmployeeDto _$RoleEmployeeDtoFromJson(Map<String, dynamic> json) =>
    RoleEmployeeDto(
      employees: (json['employees'] as List<dynamic>)
          .map((e) => EmployeeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoleEmployeeDtoToJson(RoleEmployeeDto instance) =>
    <String, dynamic>{'employees': instance.employees};
