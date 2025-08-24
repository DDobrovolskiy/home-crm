// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthResponseDto _$AuthResponseDtoFromJson(Map<String, dynamic> json) =>
    AuthResponseDto(
      status: (json['status'] as num?)?.toInt(),
      errorData: json['errorData'] == null
          ? null
          : ErrorDate.fromJson(json['errorData'] as Map<String, dynamic>),
      data: json['data'] as String?,
    );

Map<String, dynamic> _$AuthResponseDtoToJson(AuthResponseDto instance) =>
    <String, dynamic>{
      'status': instance.status,
      'errorData': instance.errorData,
      'data': instance.data,
    };
