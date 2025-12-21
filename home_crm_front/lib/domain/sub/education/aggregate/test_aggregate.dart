import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/question_aggregate.dart';
import 'package:home_crm_front/domain/sub/event/aggregate/event_aggregate.dart';

import '../../../support/components/aggregate/aggregate.dart';
import '../../../support/components/status/doc.dart';
import 'appointed_aggregate.dart';

class TestAggregate extends Aggregate {
  late int? id;
  late bool active;
  late String? name;
  late String? description;
  late StatusDoc status;
  late int timeLimitMinutes;
  late int iteration;
  late int answerCount;
  late List<QuestionAggregate> questions;
  late List<AppointedAggregate> appointed;
  late List<EventAggregate> events;

  TestAggregate({
    this.id,
    this.active = true,
    this.name = 'Новый тест',
    this.description,
    this.status = StatusDoc.DRAFT,
    this.timeLimitMinutes = 0,
    this.iteration = 0,
    this.answerCount = 0,
    List<QuestionAggregate>? questions,
    List<AppointedAggregate>? appointed,
  }) : questions = questions ?? [],
       appointed = appointed ?? [];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'active': active,
      'name': name,
      'description': description,
      'status': status.name,
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
      active: json['active'] as bool,
      name: json['name'] as String,
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

  void addAppointed(AppointedAggregate appoint) {
    if (status.ready) {
      appoint.active = true;
    }
    appointed.add(appoint);
  }

  String? doReady() {
    if (name == null || name!.isEmpty) {
      return 'Пустое название теста';
    }
    if (questions.isEmpty) {
      return 'Количество количество вопросов должено быть больше 0';
    }
    if (questions.any((q) => q.getError() != null)) {
      return questions.firstWhere((q) => q.getError() != null).getError();
    }
    if (answerCount == 0) {
      return 'Количество ответов должено быть больше 0';
    }
    status = StatusDoc.READY;
    active = true;
    for (var a in appointed) {
      a.active = true;
    }
    return null;
  }

  String? doDraft() {
    status = StatusDoc.DRAFT;
    active = true;
    for (var a in appointed) {
      a.active = false;
    }
    return null;
  }

  String? doArchive() {
    status = StatusDoc.ARCHIVE;
    active = false;
    for (var a in appointed) {
      a.active = false;
    }
    return null;
  }

  Map<StatusDoc, String? Function(TestAggregate)> statuses = {
    StatusDoc.DRAFT: (t) => t.doDraft(),
    StatusDoc.READY: (t) => t.doReady(),
    StatusDoc.ARCHIVE: (t) => t.doArchive(),
  };

  @override
  String getNewName() {
    return 'Новый тест';
  }

  @override
  String getAbbreviate() {
    return 'ТЕСТ';
  }

  TestAggregate copy() {
    return TestAggregate.fromJson(toJson());
  }

  String getName() {
    return name ??= getNewName();
  }

  Future<bool> isReady(BuildContext context) async {
    if (!status.ready ||
        (await showStausAlertDialog(status, StatusDoc.DRAFT, context) ??
            false)) {
      doDraft();
      return true;
    } else {
      return false;
    }
  }
}
