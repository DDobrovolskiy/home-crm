import 'package:json_annotation/json_annotation.dart';

import '../../../support/components/aggregate/aggregate.dart';
import 'option_aggregate.dart';

part 'question_aggregate.g.dart';

@JsonSerializable(explicitToJson: true)
class QuestionAggregate extends Aggregate {
  late String? text;
  late List<OptionAggregate> options;

  QuestionAggregate({
    super.id,
    super.active,
    super.version,
    super.createdAt,
    this.text,
    List<OptionAggregate>? options,
  }) : options = options ?? [];

  Map<String, dynamic> toJson() {
    return _$QuestionAggregateToJson(this);
  }

  factory QuestionAggregate.fromJson(Map<String, dynamic> json) =>
      _$QuestionAggregateFromJson(json);

  @override
  String getAbbreviate() {
    return 'ВОПРОС';
  }

  @override
  String getNewName() {
    return 'Новый вопрос';
  }

  String? getError() {
    if (text == null || text!.isEmpty) {
      return 'Пустой текст вопроса';
    }
    if (options.isEmpty || options.length < 2) {
      return 'Необходимо добавить хотя бы два ответа';
    }
    if (options.any((o) => o.getError() != null)) {
      return options.firstWhere((o) => o.getError() != null).getError();
    }
    if (!options.any((o) => o.correct)) {
      return 'Должен быть хотя бы один правильный ответ';
    }
    return null;
  }
}
