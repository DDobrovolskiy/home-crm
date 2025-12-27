import 'package:flutter/cupertino.dart';

abstract class Aggregate extends Id {
  late bool active;
  late int version;
  final String createdAt;

  Aggregate({super.id, this.active = true, this.version = 0, String? createdAt})
    : createdAt = createdAt ?? DateTime.now().toString();

  String getNewName();

  String getAbbreviate();

  bool isCreate() {
    return id == null;
  }

  String getNumber() {
    if (id == null) {
      return getNewName();
    } else {
      return '${getAbbreviate()}-$id';
    }
  }

  int get key => Object.hash(super.key, active, version, createdAt);

  Key getKey() {
    return ValueKey<int>(key);
  }

  @override
  String toString() {
    return 'Aggregate{super: ${super.toString()}, active: $active, version: $version, createdAt: $createdAt}';
  }
}

abstract class Id {
  late int? id;

  Id({this.id});

  int get key => id ?? 0;

  Key getKey() {
    return ValueKey<int>(key);
  }

  @override
  String toString() {
    return 'Id{id: $id}';
  }
}
