import 'package:home_crm_front/domain/sub/event/enums/event_type.dart';

class EventAggregate {
  final Event type;
  final Set<int> ids;
  final Set<int> employeesIds;

  EventAggregate({
    required this.type,
    required this.ids,
    required this.employeesIds,
  });
}
