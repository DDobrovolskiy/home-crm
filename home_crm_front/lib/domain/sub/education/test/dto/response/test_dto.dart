import 'package:home_crm_front/domain/sub/employee/dto/response/employee_dto.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../../../support/components/status/doc.dart';
import '../../../question/dto/response/question_dto.dart';

part 'test_dto.g.dart';

@JsonSerializable()
class TestDto {
  final int id;
  final String number;
  final String name;
  final String description;
  final StatusDoc status;
  final int timeLimitMinutes;
  final int iteration;
  final List<QuestionDto> questions;
  final List<EmployeeDto> employees;

  TestDto(
    this.id,
    this.number,
    this.name,
    this.description,
    this.status,
    this.timeLimitMinutes,
    this.iteration,
    this.questions,
    this.employees,
  );

  Map<String, dynamic> toJson() {
    return _$TestDtoToJson(this);
  }

  factory TestDto.fromJson(Map<String, dynamic> json) =>
      _$TestDtoFromJson(json);
}
