// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_update_ready_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestUpdateReadyDto _$TestUpdateReadyDtoFromJson(Map<String, dynamic> json) =>
    TestUpdateReadyDto(
      id: (json['id'] as num).toInt(),
      ready: json['ready'] as bool,
    );

Map<String, dynamic> _$TestUpdateReadyDtoToJson(TestUpdateReadyDto instance) =>
    <String, dynamic>{'id': instance.id, 'ready': instance.ready};
