import 'package:home_crm_front/domain/sub/user/dto/user_base_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'organization_dto.g.dart';

@JsonSerializable()
class OrganizationDto {
  final int id;
  final String name;
  final UserBaseDto owner;

  OrganizationDto({required this.id, required this.name, required this.owner});

  Map<String, dynamic> toJson() {
    return _$OrganizationDtoToJson(this);
  }

  factory OrganizationDto.fromJson(Map<String, dynamic> json) =>
      _$OrganizationDtoFromJson(json);
}
