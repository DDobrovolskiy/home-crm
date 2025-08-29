import 'package:home_crm_front/domain/sub/organization/dto/response/organization_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_organization_dto.g.dart';

@JsonSerializable()
class UserOrganizationDto {
  final List<OrganizationDto> organizations;

  UserOrganizationDto({required this.organizations});

  Map<String, dynamic> toJson() {
    return _$UserOrganizationDtoToJson(this);
  }

  factory UserOrganizationDto.fromJson(Map<String, dynamic> json) =>
      _$UserOrganizationDtoFromJson(json);
}
