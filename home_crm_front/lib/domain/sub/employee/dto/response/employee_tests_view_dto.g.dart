// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_tests_view_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeTestsViewDto _$EmployeeTestsViewDtoFromJson(
  Map<String, dynamic> json,
) => EmployeeTestsViewDto(
  employee: EmployeeDto.fromJson(json['employee'] as Map<String, dynamic>),
  employeeTests: EmployeeTestsDto.fromJson(
    json['employeeTests'] as Map<String, dynamic>,
  ),
  employeeSessions: EmployeeSessionsDto.fromJson(
    json['employeeSessions'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$EmployeeTestsViewDtoToJson(
  EmployeeTestsViewDto instance,
) => <String, dynamic>{
  'employee': instance.employee,
  'employeeTests': instance.employeeTests,
  'employeeSessions': instance.employeeSessions,
};
