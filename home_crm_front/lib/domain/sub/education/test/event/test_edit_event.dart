import '../../../../support/exceptions/exceptions.dart';

abstract class TestEditEvent {}

class TestEditRefreshEvent extends TestEditEvent {}

class TestEditLoadEvent extends TestEditEvent {
  final int? id;

  TestEditLoadEvent({required this.id});
}

class TestEditCreateEvent extends TestEditEvent {
  final String name;

  TestEditCreateEvent({required this.name});
}

class TestEditUpdateEvent extends TestEditEvent {
  final int id;
  final String name;
  final bool ready;
  final int timeLimitMinutes;

  TestEditUpdateEvent({
    required this.id,
    required this.name,
    required this.ready,
    required this.timeLimitMinutes,
  });
}

class TestEditDeleteEvent extends TestEditEvent {
  final int id;

  TestEditDeleteEvent({required this.id});
}

class TestEditErrorEvent extends TestEditEvent {
  final PortException error;

  TestEditErrorEvent({required this.error});
}
