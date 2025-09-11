import 'package:home_crm_front/domain/sub/role/dto/response/role_scopes_dto.dart';
import 'package:home_crm_front/domain/sub/scope/dto/response/scope_dto.dart';

import '../../../support/exceptions/exceptions.dart';
import '../../scope/scope.dart';
import '../dto/response/role_dto.dart';

abstract class RoleCurrentState {
  abstract final PortException? error;
  abstract final bool loaded;
  abstract final RoleDto? role;
}

class RoleCurrentInitState extends RoleCurrentState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  RoleDto? get role => null;
}

class RoleCurrentLoadedState extends RoleCurrentState {
  @override
  final RoleDto? role;

  RoleCurrentLoadedState({required this.role});

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class RoleCurrentErrorState extends RoleCurrentState {
  @override
  final PortException error;

  RoleCurrentErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  RoleDto? get role => null;
}
