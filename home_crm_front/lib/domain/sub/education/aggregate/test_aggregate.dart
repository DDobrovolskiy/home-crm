import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/question_aggregate.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../support/components/aggregate/aggregate.dart';
import '../../../support/components/status/doc.dart';
import 'appointed_aggregate.dart';

part 'test_aggregate.g.dart';

@JsonSerializable(explicitToJson: true)
class TestAggregate extends Aggregate {
  late String? name;
  late String? description;
  @StatusDocConverter()
  late StatusDoc status;
  late int timeLimitMinutes;
  late int iteration;
  late int answerCount;
  late List<QuestionAggregate> questions;
  late List<AppointedAggregate> appointed;

  TestAggregate({
    super.id,
    super.active,
    super.version,
    super.createdAt,
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

  Map<String, dynamic> toJson() {
    return _$TestAggregateToJson(this);
  }

  factory TestAggregate.fromJson(Map<String, dynamic> json) =>
      _$TestAggregateFromJson(json);

  void setName(String? name) {
    this.name = name;
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

  @override
  String? doArchive() {
    status = StatusDoc.ARCHIVE;
    active = false;
    for (var a in appointed) {
      a.active = false;
    }
    return null;
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
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

  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  int get key => Object.hash(
    super.key,
    name,
    description,
    status,
    timeLimitMinutes,
    iteration,
    answerCount,
    questions,
    appointed,
    statuses,
  );

  @override
  String toString() {
    return 'TestAggregate{super: ${super.toString()}, name: $name, description: $description, status: $status, timeLimitMinutes: $timeLimitMinutes, iteration: $iteration, answerCount: $answerCount, questions: $questions, appointed: $appointed, statuses: $statuses}';
  }
}
