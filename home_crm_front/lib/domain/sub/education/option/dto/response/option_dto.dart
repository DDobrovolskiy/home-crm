import 'package:home_crm_front/domain/sub/education/question/dto/response/question_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'option_dto.g.dart';

@JsonSerializable()
class OptionDto {
  final int id;
  final String text;
  final bool correct;
  final QuestionDto question;

  OptionDto({
    required this.id,
    required this.text,
    required this.correct,
    required this.question,
  });

  Map<String, dynamic> toJson() {
    return _$OptionDtoToJson(this);
  }

  factory OptionDto.fromJson(Map<String, dynamic> json) =>
      _$OptionDtoFromJson(json);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OptionDto && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
