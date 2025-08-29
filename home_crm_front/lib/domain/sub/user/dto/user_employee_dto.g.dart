// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_employee_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEmployeeDto _$UserEmployeeDtoFromJson(Map<String, dynamic> json) =>
    UserEmployeeDto(
      employees: (json['employees'] as List<dynamic>)
          .map((e) => EmployeeDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserEmployeeDtoToJson(UserEmployeeDto instance) =>
    <String, dynamic>{'employees': instance.employees};
