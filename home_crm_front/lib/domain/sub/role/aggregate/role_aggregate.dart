import '../../../support/components/aggregate/aggregate.dart';
import '../../scope/aggregate/scope_aggregate.dart';

class RoleAggregate extends Aggregate {
  late int? id;
  late bool active;
  late int version;
  late String name;
  late String? description;
  late bool owner;
  late List<ScopeAggregate> scopes;

  RoleAggregate({
    this.id,
    this.active = true,
    this.version = 0,
    required this.name,
    this.description,
    this.owner = false,
    this.scopes = const [],
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'version': version,
      'name': name,
      'description': description,
      'owner': owner,
      'scopes': scopes.map((e) => e.toJson()).toList(),
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
      scopes: (json['scopes'] as List<dynamic>)
          .map((e) => ScopeAggregate.fromJson(e as Map<String, dynamic>))
          .toList(),
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
