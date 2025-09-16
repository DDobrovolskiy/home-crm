import 'package:json_annotation/json_annotation.dart';

part 'test_assign_dto.g.dart';

@JsonSerializable()
class TestAssignDto {
  final int testId;
  final int employeeId;

  TestAssignDto({required this.testId, required this.employeeId});

  Map<String, dynamic> toJson() {
    return _$TestAssignDtoToJson(this);
  }

  factory TestAssignDto.fromJson(Map<String, dynamic> json) =>
      _$TestAssignDtoFromJson(json);
}
