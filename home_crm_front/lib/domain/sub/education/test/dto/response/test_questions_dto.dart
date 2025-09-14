import 'package:json_annotation/json_annotation.dart';

import '../../../question/dto/response/question_view_dto.dart';

part 'test_questions_dto.g.dart';

@JsonSerializable()
class TestQuestionsDto {
  final List<QuestionViewDto> questions;

  TestQuestionsDto({required this.questions});

  Map<String, dynamic> toJson() {
    return _$TestQuestionsDtoToJson(this);
  }

  factory TestQuestionsDto.fromJson(Map<String, dynamic> json) =>
      _$TestQuestionsDtoFromJson(json);
}
