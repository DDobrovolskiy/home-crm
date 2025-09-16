// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultDto _$ResultDtoFromJson(Map<String, dynamic> json) => ResultDto(
  id: (json['id'] as num).toInt(),
  test: TestDto.fromJson(json['test'] as Map<String, dynamic>),
  completedAt: json['completedAt'] as String,
  session: SessionDto.fromJson(json['session'] as Map<String, dynamic>),
  details: (json['details'] as List<dynamic>)
      .map((e) => ResultDetailDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ResultDtoToJson(ResultDto instance) => <String, dynamic>{
  'id': instance.id,
  'test': instance.test,
  'completedAt': instance.completedAt,
  'session': instance.session,
  'details': instance.details,
};
