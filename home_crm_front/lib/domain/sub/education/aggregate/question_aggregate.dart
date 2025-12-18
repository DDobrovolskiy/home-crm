import '../../../support/components/aggregate/aggregate.dart';
import 'option_aggregate.dart';

class QuestionAggregate extends Aggregate {
  late int? id;
  late String? text;
  late List<OptionAggregate> options;

  QuestionAggregate({this.id, this.text, this.options = const []});

  factory QuestionAggregate.fromJson(Map<String, dynamic> json) {
    return QuestionAggregate(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String?,
      options: (json['options'] as List<dynamic>)
          .map((e) => OptionAggregate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'options': options.map((q) => q.toJson()).toList(),
    };
  }

  @override
  String getAbbreviate() {
    return 'ВОПРОС';
  }

  @override
  int? getId() {
    return id;
  }

  @override
  String getNewName() {
    return 'Новый вопрос';
  }

  String? getError() {
    if (options.isEmpty || options.length < 2) {
      return 'Необходимо добавить хотя бы два ответа';
    }
    if (!options.any((o) => o.correct)) {
      return 'Должен быть хотя бы один правильный ответ';
    }
    return null;
  }
}
