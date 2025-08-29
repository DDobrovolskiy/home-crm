// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_organization_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserOrganizationDto _$UserOrganizationDtoFromJson(Map<String, dynamic> json) =>
    UserOrganizationDto(
      organizations: (json['organizations'] as List<dynamic>)
          .map((e) => OrganizationDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UserOrganizationDtoToJson(
  UserOrganizationDto instance,
) => <String, dynamic>{'organizations': instance.organizations};
