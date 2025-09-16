// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_get_or_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionGetOrCreateDto _$SessionGetOrCreateDtoFromJson(
  Map<String, dynamic> json,
) => SessionGetOrCreateDto(
  testId: (json['testId'] as num).toInt(),
  employeeId: (json['employeeId'] as num).toInt(),
);

Map<String, dynamic> _$SessionGetOrCreateDtoToJson(
  SessionGetOrCreateDto instance,
) => <String, dynamic>{
  'testId': instance.testId,
  'employeeId': instance.employeeId,
};
