// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_scopes_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoleScopesDto _$RoleScopesDtoFromJson(Map<String, dynamic> json) =>
    RoleScopesDto(
      scopes: (json['scopes'] as List<dynamic>)
          .map((e) => ScopeDTO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$RoleScopesDtoToJson(RoleScopesDto instance) =>
    <String, dynamic>{'scopes': instance.scopes};
