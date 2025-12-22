import 'package:flutter/cupertino.dart';

abstract class Aggregate {
  late int? id;
  late bool active;
  late int version;
  final String createdAt;

  Aggregate({this.id, this.active = true, this.version = 0, String? createdAt})
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

  int get key => Object.hash(id, active, version, createdAt);

  Key getKey() {
    return ValueKey<int>(key);
  }
}
