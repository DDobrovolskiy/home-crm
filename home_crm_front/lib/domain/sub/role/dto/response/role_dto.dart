import 'package:json_annotation/json_annotation.dart';

part 'role_dto.g.dart';

@JsonSerializable()
class RoleDto {
  final int id;
  final String name;
  final String description;
  final bool owner;

  RoleDto(
      {required this.id, required this.name, required this.description, required this.owner});

  Map<String, dynamic> toJson() {
    return _$RoleDtoToJson(this);
  }

  factory RoleDto.fromJson(Map<String, dynamic> json) =>
      _$RoleDtoFromJson(json);
}
