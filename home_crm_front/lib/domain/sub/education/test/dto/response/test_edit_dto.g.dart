// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_edit_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestEditDto _$TestEditDtoFromJson(Map<String, dynamic> json) => TestEditDto(
  test: TestDto.fromJson(json['test'] as Map<String, dynamic>),
  testQuestions: TestQuestionsDto.fromJson(
    json['testQuestions'] as Map<String, dynamic>,
  ),
);

Map<String, dynamic> _$TestEditDtoToJson(TestEditDto instance) =>
    <String, dynamic>{
      'test': instance.test,
      'testQuestions': instance.testQuestions,
    };
