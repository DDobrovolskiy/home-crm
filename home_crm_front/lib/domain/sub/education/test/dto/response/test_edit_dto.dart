import 'package:home_crm_front/domain/sub/education/test/dto/response/test_dto.dart';
import 'package:home_crm_front/domain/sub/education/test/dto/response/test_questions_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_edit_dto.g.dart';

@JsonSerializable()
class TestEditDto {
  final TestDto test;
  final TestQuestionsDto testQuestions;

  TestEditDto({required this.test, required this.testQuestions});

  Map<String, dynamic> toJson() {
    return _$TestEditDtoToJson(this);
  }

  factory TestEditDto.fromJson(Map<String, dynamic> json) =>
      _$TestEditDtoFromJson(json);
}
