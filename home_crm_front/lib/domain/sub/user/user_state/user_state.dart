import 'package:home_crm_front/domain/sub/user/dto/user_dto.dart';

import '../../../support/exceptions/exceptions.dart';

abstract class UserState {}

class UserInitState extends UserState {}

class UserLoadedState extends UserState {
  UserDto? user;

  UserLoadedState({required this.user});
}

class UserErrorState extends UserState {
  final PortException error;

  UserErrorState({required this.error});
}
