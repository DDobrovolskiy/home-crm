import 'package:home_crm_front/domain/sub/education/session/dto/request/session_result_question_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_result_dto.g.dart';

@JsonSerializable()
class SessionResultDto {
  final int testId;
  final int employeeId;
  final List<SessionResultQuestionDto> questions;

  SessionResultDto({
    required this.testId,
    required this.employeeId,
    required this.questions,
  });

  Map<String, dynamic> toJson() {
    return _$SessionResultDtoToJson(this);
  }

  factory SessionResultDto.fromJson(Map<String, dynamic> json) =>
      _$SessionResultDtoFromJson(json);
}
