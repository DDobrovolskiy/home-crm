// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestUpdateDto _$TestUpdateDtoFromJson(Map<String, dynamic> json) =>
    TestUpdateDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      timeLimitMinutes: (json['timeLimitMinutes'] as num).toInt(),
    );

Map<String, dynamic> _$TestUpdateDtoToJson(TestUpdateDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'timeLimitMinutes': instance.timeLimitMinutes,
    };
