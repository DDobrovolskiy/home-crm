import 'package:home_crm_front/domain/sub/education/test/dto/response/test_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_dto.g.dart';

@JsonSerializable()
class QuestionDto {
  final int id;
  final String text;
  final bool oneAnswer;
  final TestDto test;

  QuestionDto({
    required this.id,
    required this.text,
    required this.oneAnswer,
    required this.test,
  });

  Map<String, dynamic> toJson() {
    return _$QuestionDtoToJson(this);
  }

  factory QuestionDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDtoFromJson(json);
}
