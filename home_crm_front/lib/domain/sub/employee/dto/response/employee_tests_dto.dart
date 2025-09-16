import 'package:home_crm_front/domain/sub/education/test/dto/response/test_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'employee_tests_dto.g.dart';

@JsonSerializable()
class EmployeeTestsDto {
  final List<TestDto> tests;

  EmployeeTestsDto({required this.tests});

  Map<String, dynamic> toJson() {
    return _$EmployeeTestsDtoToJson(this);
  }

  factory EmployeeTestsDto.fromJson(Map<String, dynamic> json) =>
      _$EmployeeTestsDtoFromJson(json);
}
