import 'package:home_crm_front/domain/sub/education/aggregate/question_aggregate.dart';

import '../../../support/components/aggregate/aggregate.dart';
import '../../../support/components/status/doc.dart';
import 'appointed_aggregate.dart';

class TestAggregate extends Aggregate {
  late int? id;
  late String? name;
  late String? description;
  late StatusDoc status;
  late int timeLimitMinutes;
  late int iteration;
  late int answerCount;
  late List<QuestionAggregate> questions;
  late List<AppointedAggregate> appointed;

  TestAggregate({
    this.id,
    this.name,
    this.description,
    this.status = StatusDoc.DRAFT,
    this.timeLimitMinutes = 0,
    this.iteration = 0,
    this.answerCount = 0,
    this.questions = const [],
    this.appointed = const [],
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'status': status,
      'timeLimitMinutes': timeLimitMinutes,
      'iteration': iteration,
      'answerCount': answerCount,
      'questions': questions.map((q) => q.toJson()).toList(),
      'appointed': appointed.map((q) => q.toJson()).toList(),
    };
  }

  factory TestAggregate.fromJson(Map<String, dynamic> json) {
    return TestAggregate(
      id: (json['id'] as num?)?.toInt(),
      name: json['number'] as String?,
      description: json['description'] as String?,
      status: StatusDoc.fromJson(json['status'] as String),
      timeLimitMinutes: (json['timeLimitMinutes'] as num?)?.toInt() ?? 0,
      iteration: (json['iteration'] as num?)?.toInt() ?? 0,
      answerCount: (json['answerCount'] as num?)?.toInt() ?? 0,
      questions: (json['questions'] as List<dynamic>)
          .map((e) => QuestionAggregate.fromJson(e as Map<String, dynamic>))
          .toList(),
      appointed: (json['appointed'] as List<dynamic>)
          .map((e) => AppointedAggregate.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  @override
  int? getId() {
    return id;
  }

  @override
  String getNewName() {
    return 'Новый тест';
  }

  @override
  String getAbbreviate() {
    return 'ТЕСТ';
  }
}
