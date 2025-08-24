import 'package:json_annotation/json_annotation.dart';

part 'organization_delete_dto.g.dart';

@JsonSerializable()
class OrganizationDeleteDto {
  final int id;

  OrganizationDeleteDto({required this.id});

  Map<String, dynamic> toJson() {
    return _$OrganizationDeleteDtoToJson(this);
  }

  factory OrganizationDeleteDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDeleteDtoFromJson(json);
}
