import 'package:json_annotation/json_annotation.dart';

part 'role_delete_dto.g.dart';

@JsonSerializable()
class RoleDeleteDto {
  final int id;

  RoleDeleteDto({required this.id});

  Map<String, dynamic> toJson() {
    return _$RoleDeleteDtoToJson(this);
  }

  factory RoleDeleteDto.fromJson(Map<String, dynamic> json) =>
      _$RoleDeleteDtoFromJson(json);
}
