// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_base_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserBaseDto _$UserBaseDtoFromJson(Map<String, dynamic> json) => UserBaseDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  phone: json['phone'] as String,
);

Map<String, dynamic> _$UserBaseDtoToJson(UserBaseDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone': instance.phone,
    };
