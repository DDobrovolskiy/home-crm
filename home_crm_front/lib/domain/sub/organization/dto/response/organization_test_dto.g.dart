// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'organization_test_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrganizationTestDto _$OrganizationTestDtoFromJson(Map<String, dynamic> json) =>
    OrganizationTestDto(
      tests: (json['tests'] as List<dynamic>)
          .map((e) => TestViewDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$OrganizationTestDtoToJson(
  OrganizationTestDto instance,
) => <String, dynamic>{'tests': instance.tests};
