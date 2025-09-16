// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_tests_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeTestsDto _$EmployeeTestsDtoFromJson(Map<String, dynamic> json) =>
    EmployeeTestsDto(
      tests: (json['tests'] as List<dynamic>)
          .map((e) => TestDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeTestsDtoToJson(EmployeeTestsDto instance) =>
    <String, dynamic>{'tests': instance.tests};
