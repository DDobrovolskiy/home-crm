import '../../../support/components/aggregate/aggregate.dart';

class OptionAggregate extends Aggregate {
  late int? id;
  late String? text;
  late bool correct;

  OptionAggregate({this.id, this.text, this.correct = false});

  factory OptionAggregate.fromJson(Map<String, dynamic> json) {
    return OptionAggregate(
      id: (json['id'] as num?)?.toInt(),
      text: json['text'] as String?,
      correct: json['correct'] as bool? ?? false,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {'id': id, 'text': text, 'correct': correct};
  }

  @override
  String getAbbreviate() {
    return 'ОТВЕТ';
  }

  @override
  int? getId() {
    return id;
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
