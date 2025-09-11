import 'package:json_annotation/json_annotation.dart';

import '../../../scope/dto/response/scope_dto.dart';
import '../../../scope/scope.dart';

part 'role_scopes_dto.g.dart';

@JsonSerializable()
class RoleScopesDto {
  final List<ScopeDTO> scopes;

  RoleScopesDto({required this.scopes});

  Map<String, dynamic> toJson() {
    return _$RoleScopesDtoToJson(this);
  }

  factory RoleScopesDto.fromJson(Map<String, dynamic> json) =>
      _$RoleScopesDtoFromJson(json);

  bool hasScope(ScopeType scope) {
    return scopes.where((s) => s.name == scope.name).isNotEmpty;
  }
}
