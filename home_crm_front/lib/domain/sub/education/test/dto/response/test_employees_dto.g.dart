// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_employees_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestEmployeesDto _$TestEmployeesDtoFromJson(Map<String, dynamic> json) =>
    TestEmployeesDto(
      employees: (json['employees'] as List<dynamic>)
          .map((e) => EmployeeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestEmployeesDtoToJson(TestEmployeesDto instance) =>
    <String, dynamic>{'employees': instance.employees};
