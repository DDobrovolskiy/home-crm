// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  phone: json['phone'] as String,
  ownerOrganizations: (json['ownerOrganizations'] as List<dynamic>)
      .map((e) => OrganizationDto.fromJson(e as Map<String, dynamic>))
      .toList(),
  employeeOrganizations: (json['employeeOrganizations'] as List<dynamic>)
      .map((e) => EmployeeDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'phone': instance.phone,
  'ownerOrganizations': instance.ownerOrganizations,
  'employeeOrganizations': instance.employeeOrganizations,
};
