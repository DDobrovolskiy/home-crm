// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employee_update_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmployeeUpdateDto _$EmployeeUpdateDtoFromJson(Map<String, dynamic> json) =>
    EmployeeUpdateDto(
      id: (json['id'] as num).toInt(),
      roleId: (json['roleId'] as num).toInt(),
    );

Map<String, dynamic> _$EmployeeUpdateDtoToJson(EmployeeUpdateDto instance) =>
    <String, dynamic>{'id': instance.id, 'roleId': instance.roleId};
