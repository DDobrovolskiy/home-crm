import 'package:json_annotation/json_annotation.dart';

part 'question_update_dto.g.dart';

@JsonSerializable()
class QuestionUpdateDto {
  final int id;
  final String text;

  QuestionUpdateDto({required this.id, required this.text});

  Map<String, dynamic> toJson() {
    return _$QuestionUpdateDtoToJson(this);
  }

  factory QuestionUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionUpdateDtoFromJson(json);
}
