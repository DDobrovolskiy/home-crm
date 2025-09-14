import 'package:home_crm_front/domain/sub/education/option/dto/response/option_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'question_options_dto.g.dart';

@JsonSerializable()
class QuestionOptionsDto {
  final bool oneAnswer;
  final String? validMessage;
  final List<OptionDto> options;

  QuestionOptionsDto({
    required this.oneAnswer,
    required this.validMessage,
    required this.options,
  });

  Map<String, dynamic> toJson() {
    return _$QuestionOptionsDtoToJson(this);
  }

  factory QuestionOptionsDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionOptionsDtoFromJson(json);
}
