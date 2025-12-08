import 'package:home_crm_front/domain/sub/scope/dto/response/scope_dto.dart';

import '../../../support/exceptions/exceptions.dart';
import '../../../support/service/loaded.dart';

abstract class ScopeState extends StateLoad<List<ScopeDTO>> {}

class ScopeInitState extends ScopeState {
  @override
  List<ScopeDTO>? getBody() {
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

class ScopeLoadedState extends ScopeState {
  final List<ScopeDTO>? scopes;

  ScopeLoadedState({required this.scopes});

  @override
  List<ScopeDTO>? getBody() {
    return scopes;
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

class ScopeErrorState extends ScopeState {
  final PortException error;

  ScopeErrorState({required this.error});

  @override
  List<ScopeDTO>? getBody() {
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
