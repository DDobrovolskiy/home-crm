// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestDto _$TestDtoFromJson(Map<String, dynamic> json) => TestDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  ready: json['ready'] as bool,
  timeLimitMinutes: (json['timeLimitMinutes'] as num).toInt(),
  organization: OrganizationDto.fromJson(
    json['organization'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$TestDtoToJson(TestDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'ready': instance.ready,
  'timeLimitMinutes': instance.timeLimitMinutes,
  'organization': instance.organization,
};
