// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionDto _$SessionDtoFromJson(Map<String, dynamic> json) => SessionDto(
  id: (json['id'] as num).toInt(),
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  employee: EmployeeDto.fromJson(json['employee'] as Map<String, dynamic>),
  test: TestDto.fromJson(json['test'] as Map<String, dynamic>),
  active: json['active'] as bool,
);

Map<String, dynamic> _$SessionDtoToJson(SessionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'employee': instance.employee,
      'test': instance.test,
      'active': instance.active,
    };
