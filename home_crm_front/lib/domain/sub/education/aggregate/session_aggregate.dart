import 'package:json_annotation/json_annotation.dart';

import '../../../support/components/aggregate/aggregate.dart';

part 'session_aggregate.g.dart';

@JsonSerializable()
class SessionAggregate extends Aggregate {
  final DateTime dateStart;
  final DateTime dateEnd;
  final bool success;
  final int answers;

  SessionAggregate({
    super.id,
    super.active,
    super.version,
    super.createdAt,
    required this.dateStart,
    required this.dateEnd,
    required this.success,
    required this.answers,
  });

  Map<String, dynamic> toJson() {
    return _$SessionAggregateToJson(this);
  }

  factory SessionAggregate.fromJson(Map<String, dynamic> json) =>
      _$SessionAggregateFromJson(json);

  @override
  String getNewName() {
    return 'Новая сессия';
  }

  @override
  String getAbbreviate() {
    return 'СЕССИЯ';
  }

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get key => Object.hash(super.key, dateStart, dateEnd, success, answers);
}
