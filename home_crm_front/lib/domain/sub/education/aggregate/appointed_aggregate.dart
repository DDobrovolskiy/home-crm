import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/aggregate/session_aggregate.dart';
import 'package:home_crm_front/domain/sub/employee/aggregate/employee_aggregate.dart';
import 'package:home_crm_front/domain/support/components/status/doc.dart';

import '../../../support/components/aggregate/aggregate.dart';
import '../../../support/components/load/custom_load.dart';
import '../../employee/store/employee_store.dart';

class AppointedAggregate extends Aggregate {
  late int? id;
  late DateTime? deadline;
  late List<SessionAggregate> sessions;
  final int employeeId;
  final int? testId;

  AppointedAggregate({
    this.id,
    this.deadline,
    List<SessionAggregate>? sessions,
    required this.employeeId,
    required this.testId,
  }) : sessions = sessions ?? [];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deadline': deadline,
      'sessions': sessions.map((q) => q.toJson()).toList(),
      'employeeId': employeeId,
      'testId': testId,
    };
  }

  factory AppointedAggregate.fromJson(Map<String, dynamic> json) {
    return AppointedAggregate(
      id: (json['id'] as num?)?.toInt(),
      deadline: json['deadline'] as DateTime?,
      sessions: (json['sessions'] as List<dynamic>)
          .map((e) => SessionAggregate.fromJson(e as Map<String, dynamic>))
          .toList(),
      employeeId: (json['employeeId'] as num).toInt(),
      testId: (json['testId'] as num?)?.toInt(),
    );
  }

  @override
  int? getId() {
    return id;
  }

  @override
  String getNewName() {
    return 'Новое назначение';
  }

  @override
  String getAbbreviate() {
    return 'НАЗЧ';
  }

  bool isBegin() {
    return sessions.isNotEmpty;
  }

  bool isDone() {
    return sessions.any((s) => s.success);
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
}
