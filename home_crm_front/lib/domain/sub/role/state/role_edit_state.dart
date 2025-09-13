import 'package:equatable/equatable.dart';
import 'package:home_crm_front/domain/sub/role/dto/response/role_scopes_dto.dart';
import 'package:home_crm_front/domain/sub/scope/dto/response/scope_dto.dart';

import '../../../support/exceptions/exceptions.dart';
import '../../scope/scope.dart';
import '../dto/response/role_dto.dart';

abstract class RoleEditState extends Equatable {
  static ScopeType scope = ScopeType.ORGANIZATION_UPDATE;
  abstract final bool isLoading;
  abstract final bool isOnlyWatch;
  abstract final bool isEndEdit;
  abstract final RoleDto? data;
  abstract final RoleScopesDto? roleScope;
  abstract final List<ScopeDTO> scopes;
  abstract final PortException? error;

  @override
  List<Object> get props => [isLoading, isOnlyWatch, isEndEdit, ?data, ?error];
}

class RoleEditPointState extends RoleEditState {
  @override
  final bool isLoading;
  @override
  final bool isEndEdit;

  RoleEditPointState({required this.isEndEdit, required this.isLoading});

  @override
  bool get isOnlyWatch => false;

  @override
  RoleDto? get data => null;

  @override
  RoleScopesDto? get roleScope => null;

  @override
  PortException? get error => null;

  @override
  List<ScopeDTO> get scopes => [];
}

class RoleEditLoadedState extends RoleEditState {
  @override
  final RoleDto? data;
  @override
  final List<ScopeDTO> scopes;
  @override
  final bool isOnlyWatch;
  @override
  RoleScopesDto? roleScope;

  RoleEditLoadedState({
    required this.data,
    required this.scopes,
    required this.roleScope,
    required this.isOnlyWatch,
  });

  @override
  bool get isEndEdit => false;

  @override
  bool get isLoading => false;

  @override
  PortException? get error => null;
}

class RoleEditErrorState extends RoleEditState {
  @override
  final PortException error;

  RoleEditErrorState({required this.error});

  @override
  bool get isLoading => false;

  @override
  bool get isOnlyWatch => false;

  @override
  bool get isEndEdit => false;

  @override
  RoleDto? get data => null;

  @override
  RoleScopesDto? get roleScope => null;

  @override
  List<ScopeDTO> get scopes => [];
}
