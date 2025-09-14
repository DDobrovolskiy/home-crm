// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_create_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionCreateDto _$QuestionCreateDtoFromJson(Map<String, dynamic> json) =>
    QuestionCreateDto(
      text: json['text'] as String,
      testId: (json['testId'] as num).toInt(),
    );

Map<String, dynamic> _$QuestionCreateDtoToJson(QuestionCreateDto instance) =>
    <String, dynamic>{'text': instance.text, 'testId': instance.testId};
