// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationDto _$OrganizationDtoFromJson(Map<String, dynamic> json) =>
    OrganizationDto(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      owner: UserDto.fromJson(json['owner'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$OrganizationDtoToJson(OrganizationDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'owner': instance.owner,
    };
