import 'package:json_annotation/json_annotation.dart';

part 'organization_update_dto.g.dart';

@JsonSerializable()
class OrganizationUpdateDto {
  final int id;
  final String name;

  OrganizationUpdateDto({required this.id, required this.name});

  Map<String, dynamic> toJson() {
    return _$OrganizationUpdateDtoToJson(this);
  }

  factory OrganizationUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationUpdateDtoFromJson(json);
}
