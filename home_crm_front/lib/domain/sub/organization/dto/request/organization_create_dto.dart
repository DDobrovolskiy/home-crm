import 'package:json_annotation/json_annotation.dart';

part 'organization_create_dto.g.dart';

@JsonSerializable()
class OrganizationCreateDto {
  final String name;

  OrganizationCreateDto({required this.name});

  Map<String, dynamic> toJson() {
    return _$OrganizationCreateDtoToJson(this);
  }

  factory OrganizationCreateDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationCreateDtoFromJson(json);
}
