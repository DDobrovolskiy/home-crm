import 'package:json_annotation/json_annotation.dart';

import '../../../support/components/aggregate/aggregate.dart';

part 'user_aggregate.g.dart';

@JsonSerializable()
class UserAggregate extends Aggregate {
  late String name;
  late String? surname;
  late String? patronymic;
  late String phone;

  UserAggregate({
    super.id,
    super.active,
    super.version,
    super.createdAt,
    required this.name,
    this.surname,
    this.patronymic,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return _$UserAggregateToJson(this);
  }

  factory UserAggregate.fromJson(Map<String, dynamic> json) =>
      _$UserAggregateFromJson(json);

  @override
  String getAbbreviate() {
    return 'ПОЛЬЗОВАТЕЛЬ';
  }

  @override
  String getNewName() {
    return 'Новый пользователь';
  }
}
