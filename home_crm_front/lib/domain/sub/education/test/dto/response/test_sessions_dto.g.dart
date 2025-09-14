// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_sessions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestSessionsDto _$TestSessionsDtoFromJson(Map<String, dynamic> json) =>
    TestSessionsDto(
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestSessionsDtoToJson(TestSessionsDto instance) =>
    <String, dynamic>{'sessions': instance.sessions};
