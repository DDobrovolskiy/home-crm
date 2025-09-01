// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_employee_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationEmployeeDto _$OrganizationEmployeeDtoFromJson(
  Map<String, dynamic> json,
) => OrganizationEmployeeDto(
  employees: (json['employees'] as List<dynamic>)
      .map((e) => EmployeeDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrganizationEmployeeDtoToJson(
  OrganizationEmployeeDto instance,
) => <String, dynamic>{'employees': instance.employees};
