// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_test_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionTestDto _$SessionTestDtoFromJson(Map<String, dynamic> json) =>
    SessionTestDto(
      test: TestQuestionsDto.fromJson(json['test'] as Map<String, dynamic>),
      session: SessionDto.fromJson(json['session'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionTestDtoToJson(SessionTestDto instance) =>
    <String, dynamic>{'session': instance.session, 'test': instance.test};
