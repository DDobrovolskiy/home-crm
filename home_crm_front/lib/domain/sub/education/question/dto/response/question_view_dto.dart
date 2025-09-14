import 'package:home_crm_front/domain/sub/education/question/dto/response/question_dto.dart';
import 'package:home_crm_front/domain/sub/education/question/dto/response/question_options_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_view_dto.g.dart';

@JsonSerializable()
class QuestionViewDto {
  final QuestionDto question;
  final QuestionOptionsDto questionOptions;

  QuestionViewDto({required this.question, required this.questionOptions});

  Map<String, dynamic> toJson() {
    return _$QuestionViewDtoToJson(this);
  }

  factory QuestionViewDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionViewDtoFromJson(json);
}
