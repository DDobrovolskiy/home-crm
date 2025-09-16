// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionResultDto _$SessionResultDtoFromJson(Map<String, dynamic> json) =>
    SessionResultDto(
      sessionId: (json['sessionId'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map(
            (e) => SessionResultQuestionDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$SessionResultDtoToJson(SessionResultDto instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'questions': instance.questions,
    };
