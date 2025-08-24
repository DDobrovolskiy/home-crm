// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationUpdateDto _$OrganizationUpdateDtoFromJson(
  Map<String, dynamic> json,
) => OrganizationUpdateDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
);

Map<String, dynamic> _$OrganizationUpdateDtoToJson(
  OrganizationUpdateDto instance,
) => <String, dynamic>{'id': instance.id, 'name': instance.name};
