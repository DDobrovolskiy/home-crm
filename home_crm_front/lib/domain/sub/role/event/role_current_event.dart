import '../../../support/exceptions/exceptions.dart';

abstract class RoleCurrentEvent {}

class RoleCurrentRefreshEvent extends RoleCurrentEvent {}

class RoleCurrentErrorEvent extends RoleCurrentEvent {
  final PortException error;

  RoleCurrentErrorEvent({required this.error});
}
