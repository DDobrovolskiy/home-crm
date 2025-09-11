import '../../../support/exceptions/exceptions.dart';

abstract class RoleEditEvent {}

class RoleEditRefreshEvent extends RoleEditEvent {}

class RoleEditLoadEvent extends RoleEditEvent {
  final int? id;

  RoleEditLoadEvent({required this.id});
}

class RoleEditCreateEvent extends RoleEditEvent {
  final String name;
  final String description;
  final List<int> scopes;

  RoleEditCreateEvent({
    required this.name,
    required this.description,
    required this.scopes,
  });
}

class RoleEditUpdateEvent extends RoleEditEvent {
  final int id;
  final String name;
  final String description;
  final List<int> scopes;

  RoleEditUpdateEvent({
    required this.id,
    required this.name,
    required this.description,
    required this.scopes,
  });
}

class RoleEditDeleteEvent extends RoleEditEvent {
  final int id;

  RoleEditDeleteEvent({required this.id});
}

class RoleEditErrorEvent extends RoleEditEvent {
  final PortException error;

  RoleEditErrorEvent({required this.error});
}
