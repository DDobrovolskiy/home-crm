import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/scope/store/scope_store.dart';

import '../../../support/components/aggregate/aggregate.dart';
import '../../../support/components/load/custom_load.dart';
import '../../scope/aggregate/scope_aggregate.dart';

class RoleAggregate extends Aggregate {
  late int? id;
  late bool active;
  late int version;
  late String name;
  late String? description;
  late bool owner;
  late Set<int> scopeIds;

  RoleAggregate({
    this.id,
    this.active = true,
    this.version = 0,
    required this.name,
    this.description,
    this.owner = false,
    Set<int>? scopeIds,
  }) : scopeIds = scopeIds ?? {};

  LoadStore<Set<ScopeAggregate>> getScopes() {
    return GetIt.I.get<ScopeStore>().gets(scopeIds);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'version': version,
      'name': name,
      'description': description,
      'owner': owner,
      'scopeIds': scopeIds.map((e) => e.toString()).toList(),
    };
  }

  factory RoleAggregate.fromJson(Map<String, dynamic> json) {
    return RoleAggregate(
      id: (json['id'] as num?)?.toInt(),
      active: json['active'] as bool? ?? true,
      version: (json['version'] as num?)?.toInt() ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      owner: json['owner'] as bool? ?? false,
      scopeIds: (json['scopeIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toSet(),
    );
  }

  @override
  String getAbbreviate() {
    return 'РОЛЬ';
  }

  @override
  int? getId() {
    return id;
  }

  @override
  String getNewName() {
    return 'Новая роль';
  }
}
