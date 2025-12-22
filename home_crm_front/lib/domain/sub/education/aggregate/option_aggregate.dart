import 'package:json_annotation/json_annotation.dart';

import '../../../support/components/aggregate/aggregate.dart';

part 'option_aggregate.g.dart';

@JsonSerializable()
class OptionAggregate extends Aggregate {
  late String? text;
  late bool correct;

  OptionAggregate({
    super.id,
    super.active,
    super.version,
    super.createdAt,
    this.text,
    this.correct = false,
  });

  Map<String, dynamic> toJson() {
    return _$OptionAggregateToJson(this);
  }

  factory OptionAggregate.fromJson(Map<String, dynamic> json) =>
      _$OptionAggregateFromJson(json);

  @override
  String getAbbreviate() {
    return 'ОТВЕТ';
  }

  @override
  String getNewName() {
    return 'Новый ответ';
  }

  String? getError() {
    if (text == null || text!.isEmpty) {
      return 'Пустой текст ответа';
    }
    return null;
  }
}
