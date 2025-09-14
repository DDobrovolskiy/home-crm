import 'package:home_crm_front/domain/sub/education/test/dto/response/test_dto.dart';
import 'package:home_crm_front/domain/sub/education/test/dto/response/test_employees_dto.dart';
import 'package:home_crm_front/domain/sub/education/test/dto/response/test_sessions_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_view_dto.g.dart';

@JsonSerializable()
class TestViewDto {
  final TestDto test;
  final TestEmployeesDto testEmployees;
  final TestSessionsDto testSessions;

  TestViewDto({
    required this.test,
    required this.testEmployees,
    required this.testSessions,
  });

  Map<String, dynamic> toJson() {
    return _$TestViewDtoToJson(this);
  }

  factory TestViewDto.fromJson(Map<String, dynamic> json) =>
      _$TestViewDtoFromJson(json);
}
