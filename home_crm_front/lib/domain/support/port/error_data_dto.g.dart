// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDate _$ErrorDateFromJson(Map<String, dynamic> json) => ErrorDate(
  errors: (json['errors'] as List<dynamic>?)
      ?.map((e) => Fail.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ErrorDateToJson(ErrorDate instance) => <String, dynamic>{
  'errors': instance.errors,
};
