// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_view_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestViewDto _$TestViewDtoFromJson(Map<String, dynamic> json) => TestViewDto(
  test: TestDto.fromJson(json['test'] as Map<String, dynamic>),
  testEmployees: TestEmployeesDto.fromJson(
    json['testEmployees'] as Map<String, dynamic>,
  ),
  testSessions: TestSessionsDto.fromJson(
    json['testSessions'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$TestViewDtoToJson(TestViewDto instance) =>
    <String, dynamic>{
      'test': instance.test,
      'testEmployees': instance.testEmployees,
      'testSessions': instance.testSessions,
    };
