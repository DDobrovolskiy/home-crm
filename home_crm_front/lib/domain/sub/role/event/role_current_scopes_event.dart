import '../../../support/exceptions/exceptions.dart';

abstract class RoleCurrentScopesEvent {}

class RoleCurrentScopesRefreshEvent extends RoleCurrentScopesEvent {}

class RoleCurrentScopesErrorEvent extends RoleCurrentScopesEvent {
  final PortException error;

  RoleCurrentScopesErrorEvent({required this.error});
}
