import 'package:json_annotation/json_annotation.dart';

part 'role_create_dto.g.dart';

@JsonSerializable()
class RoleCreateDto {
  final String name;
  final String description;
  final List<int> scopes;

  RoleCreateDto({
    required this.name,
    required this.description,
    required this.scopes,
  });

  Map<String, dynamic> toJson() {
    return _$RoleCreateDtoToJson(this);
  }

  factory RoleCreateDto.fromJson(Map<String, dynamic> json) =>
      _$RoleCreateDtoFromJson(json);
}
