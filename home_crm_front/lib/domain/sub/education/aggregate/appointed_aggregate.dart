import 'package:home_crm_front/domain/sub/education/aggregate/session_aggregate.dart';

import '../../../support/components/aggregate/aggregate.dart';

class AppointedAggregate extends Aggregate {
  late int? id;
  late DateTime? deadline;
  late List<SessionAggregate> sessions;
  final int employeeId;

  AppointedAggregate({
    this.id,
    this.deadline,
    List<SessionAggregate>? sessions,
    required this.employeeId,
  }) : sessions = sessions ?? [];

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'deadline': deadline,
      'sessions': sessions.map((q) => q.toJson()).toList(),
      'employeeId': employeeId,
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

  int getAttempts() {
    return sessions.length;
  }
}
