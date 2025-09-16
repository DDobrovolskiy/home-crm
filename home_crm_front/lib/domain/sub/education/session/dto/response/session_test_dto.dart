import 'package:home_crm_front/domain/sub/education/question/dto/response/question_view_dto.dart';
import 'package:home_crm_front/domain/sub/education/session/dto/response/session_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_test_dto.g.dart';

@JsonSerializable()
class SessionTestDto {
  final SessionDto session;
  final QuestionViewDto test;

  SessionTestDto({required this.test, required this.session});

  Map<String, dynamic> toJson() {
    return _$SessionTestDtoToJson(this);
  }

  factory SessionTestDto.fromJson(Map<String, dynamic> json) =>
      _$SessionTestDtoFromJson(json);
}
