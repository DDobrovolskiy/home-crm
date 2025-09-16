// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultDetailDto _$ResultDetailDtoFromJson(Map<String, dynamic> json) =>
    ResultDetailDto(
      id: (json['id'] as num).toInt(),
      questionText: json['questionText'] as String,
      isCorrect: json['isCorrect'] as bool,
    );

Map<String, dynamic> _$ResultDetailDtoToJson(ResultDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'questionText': instance.questionText,
      'isCorrect': instance.isCorrect,
    };
