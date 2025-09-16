import 'package:home_crm_front/domain/sub/education/session/dto/response/session_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../test/dto/response/test_questions_dto.dart';

part 'session_test_dto.g.dart';

@JsonSerializable()
class SessionTestDto {
  final SessionDto session;
  final TestQuestionsDto test;

  SessionTestDto({required this.test, required this.session});

  Map<String, dynamic> toJson() {
    return _$SessionTestDtoToJson(this);
  }

  factory SessionTestDto.fromJson(Map<String, dynamic> json) =>
      _$SessionTestDtoFromJson(json);
}
