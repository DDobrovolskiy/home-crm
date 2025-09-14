import 'package:home_crm_front/domain/sub/education/test/dto/response/test_view_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_test_dto.g.dart';

@JsonSerializable()
class OrganizationTestDto {
  final List<TestViewDto> tests;

  OrganizationTestDto({required this.tests});

  Map<String, dynamic> toJson() {
    return _$OrganizationTestDtoToJson(this);
  }

  factory OrganizationTestDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationTestDtoFromJson(json);
}
