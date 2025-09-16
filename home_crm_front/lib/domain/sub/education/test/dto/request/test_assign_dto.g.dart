// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_assign_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestAssignDto _$TestAssignDtoFromJson(Map<String, dynamic> json) =>
    TestAssignDto(
      testId: (json['testId'] as num).toInt(),
      employeeId: (json['employeeId'] as num).toInt(),
    );

Map<String, dynamic> _$TestAssignDtoToJson(TestAssignDto instance) =>
    <String, dynamic>{
      'testId': instance.testId,
      'employeeId': instance.employeeId,
    };
