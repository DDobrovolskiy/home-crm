import 'package:json_annotation/json_annotation.dart';

part 'session_result_question_dto.g.dart';

@JsonSerializable()
class SessionResultQuestionDto {
  final int questionId;
  final Set<int> options;

  SessionResultQuestionDto({required this.questionId, required this.options});

  Map<String, dynamic> toJson() {
    return _$SessionResultQuestionDtoToJson(this);
  }

  factory SessionResultQuestionDto.fromJson(Map<String, dynamic> json) =>
      _$SessionResultQuestionDtoFromJson(json);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SessionResultQuestionDto &&
          runtimeType == other.runtimeType &&
          questionId == other.questionId;

  @override
  int get hashCode => questionId.hashCode;
}
