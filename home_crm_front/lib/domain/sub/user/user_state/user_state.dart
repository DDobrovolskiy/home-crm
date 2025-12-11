import 'package:home_crm_front/domain/sub/user/dto/user_dto.dart';

import '../../../support/exceptions/exceptions.dart';
import '../../../support/service/loaded.dart';

abstract class UserState extends StateLoad<UserDto> {}

class UserInitState extends UserState {
  @override
  UserDto? getBody() {
    return null;
  }

  @override
  PortException? getError() {
    return null;
  }

  @override
  bool loaded() {
    return false;
  }
}

class UserLoadedState extends UserState {
  UserDto? user;

  UserLoadedState({required this.user});

  @override
  UserDto? getBody() {
    return user;
  }

  @override
  PortException? getError() {
    return null;
  }

  @override
  bool loaded() {
    return true;
  }
}

class UserErrorState extends UserState {
  final PortException error;

  UserErrorState({required this.error});

  @override
  UserDto? getBody() {
    return null;
  }

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return true;
  }
}
