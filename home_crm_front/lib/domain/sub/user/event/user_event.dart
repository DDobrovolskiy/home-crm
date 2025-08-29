import 'package:home_crm_front/domain/sub/user/user_state/user_state.dart';

abstract class UserEvent {}

class UserLoadEvent extends UserEvent {}

class UserOrganizationDeleteEvent extends UserEvent {
  final int organizationId;
  final UserLoadState state;

  UserOrganizationDeleteEvent(
      {required this.organizationId, required this.state});
}
