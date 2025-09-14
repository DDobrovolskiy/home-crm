import 'package:json_annotation/json_annotation.dart';

part 'question_delete_dto.g.dart';

@JsonSerializable()
class QuestionDeleteDto {
  final int id;

  QuestionDeleteDto({required this.id});

  Map<String, dynamic> toJson() {
    return _$QuestionDeleteDtoToJson(this);
  }

  factory QuestionDeleteDto.fromJson(Map<String, dynamic> json) =>
      _$QuestionDeleteDtoFromJson(json);
}
