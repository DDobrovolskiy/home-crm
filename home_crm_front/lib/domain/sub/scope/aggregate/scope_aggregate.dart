import 'package:json_annotation/json_annotation.dart';

import '../../../support/components/aggregate/aggregate.dart';

class ScopeAggregate extends Loader {
  final String name;
  final String description;

  ScopeAggregate({
    required super.id,
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'description': description};
  }

  factory ScopeAggregate.fromJson(Map<String, dynamic> json) {
    return ScopeAggregate(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      description: json['description'] as String,
    );
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get key => Object.hash(super.key, name, description);
}
