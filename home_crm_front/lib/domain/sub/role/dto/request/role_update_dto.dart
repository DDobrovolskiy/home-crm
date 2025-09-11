import 'package:json_annotation/json_annotation.dart';

part 'role_update_dto.g.dart';

@JsonSerializable()
class RoleUpdateDto {
  final int id;
  final String name;
  final String description;
  final List<int> scopes;

  RoleUpdateDto({
    required this.id,
    required this.name,
    required this.description,
    required this.scopes,
  });

  Map<String, dynamic> toJson() {
    return _$RoleUpdateDtoToJson(this);
  }

  factory RoleUpdateDto.fromJson(Map<String, dynamic> json) =>
      _$RoleUpdateDtoFromJson(json);
}
