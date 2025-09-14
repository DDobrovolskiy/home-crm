// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question_options_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QuestionOptionsDto _$QuestionOptionsDtoFromJson(Map<String, dynamic> json) =>
    QuestionOptionsDto(
      oneAnswer: json['oneAnswer'] as bool,
      validMessage: json['validMessage'] as String?,
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QuestionOptionsDtoToJson(QuestionOptionsDto instance) =>
    <String, dynamic>{
      'oneAnswer': instance.oneAnswer,
      'validMessage': instance.validMessage,
      'options': instance.options,
    };
