import 'package:json_annotation/json_annotation.dart';

part 'scope_dto.g.dart';

@JsonSerializable()
class ScopeDTO {
  final int id;
  final String name;
  final String description;

  ScopeDTO({required this.id, required this.name, required this.description});

  Map<String, dynamic> toJson() {
    return _$ScopeDTOToJson(this);
  }

  factory ScopeDTO.fromJson(Map<String, dynamic> json) =>
      _$ScopeDTOFromJson(json);

  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ScopeDTO &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          description == other.description;

  @override
  int get hashCode => Object.hash(id, name, description);
}
