import 'package:home_crm_front/domain/sub/role/dto/response/role_scopes_dto.dart';
import 'package:home_crm_front/domain/sub/scope/dto/response/scope_dto.dart';

import '../../../support/exceptions/exceptions.dart';
import '../../scope/scope.dart';

abstract class RoleCurrentScopesState {
  abstract final PortException? error;
  abstract final bool loaded;
  abstract final RoleScopesDto? role;

  bool hasScope(ScopeType scope) {
    return role?.scopes.firstWhere((s) => s.name == scope.name) != null;
  }
}

class RoleCurrentScopesInitState extends RoleCurrentScopesState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  RoleScopesDto? get role => null;
}

class RoleCurrentScopesLoadedState extends RoleCurrentScopesState {
  @override
  final RoleScopesDto? role;

  RoleCurrentScopesLoadedState({required this.role});

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class RoleCurrentScopesErrorState extends RoleCurrentScopesState {
  @override
  final PortException error;

  RoleCurrentScopesErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  RoleScopesDto? get role => null;
}
