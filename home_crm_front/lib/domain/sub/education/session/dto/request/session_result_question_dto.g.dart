// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_result_question_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionResultQuestionDto _$SessionResultQuestionDtoFromJson(
  Map<String, dynamic> json,
) => SessionResultQuestionDto(
  questionId: (json['questionId'] as num).toInt(),
  options: (json['options'] as List<dynamic>)
      .map((e) => (e as num).toInt())
      .toSet(),
);

Map<String, dynamic> _$SessionResultQuestionDtoToJson(
  SessionResultQuestionDto instance,
) => <String, dynamic>{
  'questionId': instance.questionId,
  'options': instance.options.toList(),
};
