import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/scope/store/scope_store.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../support/components/aggregate/aggregate.dart';
import '../../../support/components/load/custom_load.dart';
import '../../scope/aggregate/scope_aggregate.dart';

part 'role_aggregate.g.dart';

@JsonSerializable()
class RoleAggregate extends Aggregate {
  late String name;
  late String? description;
  late bool owner;
  late Set<int> scopeIds;

  RoleAggregate({
    super.id,
    super.active,
    super.version,
    super.createdAt,
    required this.name,
    this.description,
    this.owner = false,
    Set<int>? scopeIds,
  }) : scopeIds = scopeIds ?? {};

  LoadStore<Set<ScopeAggregate>> getScopes() {
    return GetIt.I.get<ScopeStore>().gets(scopeIds);
  }

  Map<String, dynamic> toJson() {
    return _$RoleAggregateToJson(this);
  }

  factory RoleAggregate.fromJson(Map<String, dynamic> json) =>
      _$RoleAggregateFromJson(json);

  @override
  String getAbbreviate() {
    return 'РОЛЬ';
  }

  @override
  String getNewName() {
    return 'Новая роль';
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get key => Object.hash(super.key, name, description, owner, scopeIds);
}
