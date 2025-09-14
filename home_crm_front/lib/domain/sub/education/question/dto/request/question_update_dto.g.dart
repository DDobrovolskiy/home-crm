// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionUpdateDto _$QuestionUpdateDtoFromJson(Map<String, dynamic> json) =>
    QuestionUpdateDto(
      id: (json['id'] as num).toInt(),
      text: json['text'] as String,
    );

Map<String, dynamic> _$QuestionUpdateDtoToJson(QuestionUpdateDto instance) =>
    <String, dynamic>{'id': instance.id, 'text': instance.text};
