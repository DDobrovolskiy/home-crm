// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionResultDto _$SessionResultDtoFromJson(Map<String, dynamic> json) =>
    SessionResultDto(
      testId: (json['testId'] as num).toInt(),
      employeeId: (json['employeeId'] as num).toInt(),
      questions: (json['questions'] as List<dynamic>)
          .map(
            (e) => SessionResultQuestionDto.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$SessionResultDtoToJson(SessionResultDto instance) =>
    <String, dynamic>{
      'testId': instance.testId,
      'employeeId': instance.employeeId,
      'questions': instance.questions,
    };
