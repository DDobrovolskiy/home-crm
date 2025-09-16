// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_employee_test_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationEmployeeTestDto _$OrganizationEmployeeTestDtoFromJson(
  Map<String, dynamic> json,
) => OrganizationEmployeeTestDto(
  employees: (json['employees'] as List<dynamic>)
      .map((e) => EmployeeTestsViewDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OrganizationEmployeeTestDtoToJson(
  OrganizationEmployeeTestDto instance,
) => <String, dynamic>{'employees': instance.employees};
