import '../../../support/exceptions/exceptions.dart';

abstract class UserEvent {}

class UserLoadEvent extends UserEvent {}

class UserErrorEvent extends UserEvent {
  final PortException error;

  UserErrorEvent({required this.error});
}
