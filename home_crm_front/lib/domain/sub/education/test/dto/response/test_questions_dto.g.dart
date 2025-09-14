// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_questions_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestQuestionsDto _$TestQuestionsDtoFromJson(Map<String, dynamic> json) =>
    TestQuestionsDto(
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestQuestionsDtoToJson(TestQuestionsDto instance) =>
    <String, dynamic>{'questions': instance.questions};
