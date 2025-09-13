import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/scope/scope.dart';
import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

import '../repository/role_repository.dart';
import '../state/role_current_scopes_state.dart';

class RoleCurrentScopesCubit extends Cubit<RoleCurrentScopesState> {
  RoleCurrentScopesCubit() : super(RoleCurrentScopesInitState()) {
    print('CREATE: RoleCurrentScopesCubit');
    emit(RoleCurrentScopesInitState());
  }

  late final RoleRepository _roleRepository = GetIt.instance
      .get<RoleRepository>();

  Future<bool> checkScopeNoSafe(ScopeType scope) async {
    bool flag = await checkScope(scope);
    if (!flag) {
      throw PortException(
        message: 'Недостаточно прав, нужны права: ${scope.description}',
        auth: false,
      );
    }
    return flag;
  }

  Future<bool> checkScope(ScopeType scope) async {
    if (state is RoleCurrentScopesLoadedState) {
      if (state.role?.hasNotScope(scope) ?? true) {
        return false;
      } else {
        return true;
      }
    } else {
      emit(RoleCurrentScopesInitState());
      var roleScopesDto = await _roleRepository.roleCurrentScopes();
      emit(RoleCurrentScopesLoadedState(role: roleScopesDto));
      return checkScope(scope);
    }
  }
}
