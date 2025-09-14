import 'package:json_annotation/json_annotation.dart';

import '../../../../organization/dto/response/organization_dto.dart';

part 'test_dto.g.dart';

@JsonSerializable()
class TestDto {
  final int id;
  final String name;
  final bool ready;
  final int timeLimitMinutes;
  final OrganizationDto organization;

  TestDto({
    required this.id,
    required this.name,
    required this.ready,
    required this.timeLimitMinutes,
    required this.organization,
  });

  Map<String, dynamic> toJson() {
    return _$TestDtoToJson(this);
  }

  factory TestDto.fromJson(Map<String, dynamic> json) =>
      _$TestDtoFromJson(json);
}
