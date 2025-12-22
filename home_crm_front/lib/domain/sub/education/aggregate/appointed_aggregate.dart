import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/session_aggregate.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/test_aggregate.dart';
import 'package:home_crm_front/domain/sub/education/store/education_store.dart';
import 'package:home_crm_front/domain/sub/employee/aggregate/employee_aggregate.dart';
import 'package:home_crm_front/domain/support/components/status/doc.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../support/components/aggregate/aggregate.dart';
import '../../../support/components/load/custom_load.dart';
import '../../employee/store/employee_store.dart';

part 'appointed_aggregate.g.dart';

@JsonSerializable(explicitToJson: true)
class AppointedAggregate extends Aggregate {
  late DateTime? deadline;
  late List<SessionAggregate> sessions;
  final int employeeId;
  final int? testId;

  AppointedAggregate({
    super.id,
    super.active,
    super.version,
    super.createdAt,
    this.deadline,
    List<SessionAggregate>? sessions,
    required this.employeeId,
    required this.testId,
  }) : sessions = sessions ?? [];

  Map<String, dynamic> toJson() {
    return _$AppointedAggregateToJson(this);
  }

  factory AppointedAggregate.fromJson(Map<String, dynamic> json) =>
      _$AppointedAggregateFromJson(json);

  @override
  String getNewName() {
    return 'Новое тестирование';
  }

  @override
  String getAbbreviate() {
    return 'ТЕСТИРОВАНИЕ';
  }

  bool isBegin() {
    return sessions.isNotEmpty;
  }

  bool isDone() {
    return sessions.any((s) => s.success);
  }

  StatusDoc isActive() {
    return active ? StatusDoc.ACTIVE : StatusDoc.NOT_ACTIVE;
  }

  StatusDoc isStatus(int iteration) {
    if (!isBegin()) {
      return StatusDoc.WAIT;
    } else {
      if (isDone()) {
        return StatusDoc.DONE;
      } else {
        if (iteration >= getAttempts()) {
          return StatusDoc.FAILED;
        } else {
          return StatusDoc.BEGIN;
        }
      }
    }
  }

  int getAttempts() {
    return sessions.length;
  }

  LoadStore<EmployeeAggregate?> getEmployee() {
    return GetIt.I.get<EmployeeStore>().get(employeeId);
  }

  LoadStore<TestAggregate?> getTest() {
    return GetIt.I.get<EducationStore>().get(testId!);
  }
}
