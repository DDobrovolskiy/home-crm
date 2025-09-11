import 'package:home_crm_front/domain/sub/scope/dto/response/scope_dto.dart';

import '../../../support/exceptions/exceptions.dart';

abstract class ScopeState {
  abstract final PortException? error;
  abstract final bool loaded;
  abstract final List<ScopeDTO>? scopes;
}

class ScopeInitState extends ScopeState {
  @override
  PortException? get error => null;

  @override
  bool get loaded => false;

  @override
  List<ScopeDTO>? get scopes => [];
}

class ScopeLoadedState extends ScopeState {
  @override
  final List<ScopeDTO>? scopes;

  ScopeLoadedState({required this.scopes});

  @override
  PortException? get error => null;

  @override
  bool get loaded => true;
}

class ScopeErrorState extends ScopeState {
  @override
  final PortException error;

  ScopeErrorState({required this.error});

  @override
  bool get loaded => true;

  @override
  List<ScopeDTO>? get scopes => [];
}
