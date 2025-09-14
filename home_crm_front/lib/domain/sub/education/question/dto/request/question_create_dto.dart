import 'package:json_annotation/json_annotation.dart';

part 'question_create_dto.g.dart';

@JsonSerializable()
class QuestionCreateDto {
  final String text;
  final int testId;

  QuestionCreateDto({required this.text, required this.testId});

  Map<String, dynamic> toJson() {
    return _$QuestionCreateDtoToJson(this);
  }

  factory QuestionCreateDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionCreateDtoFromJson(json);
}
