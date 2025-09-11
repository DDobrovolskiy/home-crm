import '../../../support/exceptions/exceptions.dart';

abstract class ScopeEvent {}

class ScopeRefreshEvent extends ScopeEvent {}

class ScopeErrorEvent extends ScopeEvent {
  final PortException error;

  ScopeErrorEvent({required this.error});
}
