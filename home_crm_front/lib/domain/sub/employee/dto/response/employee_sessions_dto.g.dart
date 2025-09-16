// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_sessions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeSessionsDto _$EmployeeSessionsDtoFromJson(Map<String, dynamic> json) =>
    EmployeeSessionsDto(
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$EmployeeSessionsDtoToJson(
  EmployeeSessionsDto instance,
) => <String, dynamic>{'sessions': instance.sessions};
