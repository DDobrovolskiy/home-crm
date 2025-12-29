import 'package:flutter/cupertino.dart';

abstract class Aggregate extends Loader {
  late bool active;
  late int version;
  final String createdAt;

  Aggregate({super.id, this.active = true, this.version = 0, String? createdAt})
    : createdAt = createdAt ?? DateTime.now().toString();

  String getNewName();

  String getAbbreviate();

  String? doArchive() {
    active = false;
    return null;
  }

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

  @override
  Key getKey() {
    return ValueKey<int>(key);
  }

  @override
  String toString() {
    return 'Aggregate{super: ${super.toString()}, active: $active, version: $version, createdAt: $createdAt}';
  }
}

abstract class Loader extends Id {
  late bool load = false;

  Loader({super.id});

  int get key => Object.hash(super.key, load);

  @override
  Key getKey() {
    return ValueKey<int>(key);
  }

  @override
  String toString() {
    return 'Loader{super: ${super.toString()} load: $load}';
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
