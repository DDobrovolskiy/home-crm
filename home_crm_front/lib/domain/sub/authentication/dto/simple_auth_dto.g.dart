// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_auth_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SimpleAuthDto _$SimpleAuthDtoFromJson(Map<String, dynamic> json) =>
    SimpleAuthDto(
      name: json['name'] as String,
      phone: json['phone'] as String,
      password: json['password'] as String,
    );

Map<String, dynamic> _$SimpleAuthDtoToJson(SimpleAuthDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'phone': instance.phone,
      'password': instance.password,
    };
