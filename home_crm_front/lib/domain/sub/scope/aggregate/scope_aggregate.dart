class ScopeAggregate {
  final int id;
  final String name;
  final String description;

  ScopeAggregate({
    required this.id,
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
}
