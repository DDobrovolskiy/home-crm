// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_aggregate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAggregate _$UserAggregateFromJson(Map<String, dynamic> json) =>
    UserAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] as String?,
      name: json['name'] as String,
      surname: json['surname'] as String?,
      patronymic: json['patronymic'] as String?,
      phone: json['phone'] as String,
    );

Map<String, dynamic> _$UserAggregateToJson(UserAggregate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'active': instance.active,
      'version': instance.version,
      'createdAt': instance.createdAt,
      'name': instance.name,
      'surname': instance.surname,
      'patronymic': instance.patronymic,
      'phone': instance.phone,
    };
