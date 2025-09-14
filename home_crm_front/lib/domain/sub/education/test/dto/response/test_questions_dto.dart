import 'package:home_crm_front/domain/sub/education/question/dto/response/question_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_questions_dto.g.dart';

@JsonSerializable()
class TestQuestionsDto {
  final List<QuestionDto> questions;

  TestQuestionsDto({required this.questions});

  Map<String, dynamic> toJson() {
    return _$TestQuestionsDtoToJson(this);
  }

  factory TestQuestionsDto.fromJson(Map<String, dynamic> json) =>
      _$TestQuestionsDtoFromJson(json);
}
