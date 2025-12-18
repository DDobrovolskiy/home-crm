import '../../../support/components/aggregate/aggregate.dart';

class SessionAggregate extends Aggregate {
  final int id;
  final DateTime dateStart;
  final DateTime dateEnd;
  final bool success;
  final int answers;

  SessionAggregate({
    required this.id,
    required this.dateStart,
    required this.dateEnd,
    required this.success,
    required this.answers,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'success': success,
      'answers': answers,
    };
  }

  factory SessionAggregate.fromJson(Map<String, dynamic> json) {
    return SessionAggregate(
      id: (json['id'] as num).toInt(),
      dateStart: json['dateStart'] as DateTime,
      dateEnd: json['dateEnd'] as DateTime,
      success: json['success'] as bool,
      answers: (json['answers'] as num).toInt(),
    );
  }

  @override
  int? getId() {
    return id;
  }

  @override
  String getNewName() {
    return 'Новая сессия';
  }

  @override
  String getAbbreviate() {
    return 'СЕССИЯ';
  }
}
