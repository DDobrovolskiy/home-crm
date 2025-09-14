// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_view_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionViewDto _$QuestionViewDtoFromJson(Map<String, dynamic> json) =>
    QuestionViewDto(
      question: QuestionDto.fromJson(json['question'] as Map<String, dynamic>),
      questionOptions: QuestionOptionsDto.fromJson(
        json['questionOptions'] as Map<String, dynamic>,
      ),
    );

Map<String, dynamic> _$QuestionViewDtoToJson(QuestionViewDto instance) =>
    <String, dynamic>{
      'question': instance.question,
      'questionOptions': instance.questionOptions,
    };
