import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/repository/organization_repository.dart';

import '../../../support/port/port.dart';
import '../../role/cubit/role_current_scopes.dart';
import '../event/organization_role_event.dart';
import '../state/organization_role_state.dart';

class OrganizationRoleBloc
    extends Bloc<OrganizationRoleEvent, OrganizationRoleState> {
  late final OrganizationRepository _organizationRepository = GetIt.instance
      .get<OrganizationRepository>();
  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.instance
      .get<RoleCurrentScopesCubit>();

  OrganizationRoleBloc() : super(OrganizationRoleInitState()) {
    on<OrganizationRoleRefreshEvent>((event, emit) async {
      emit.call(OrganizationRoleInitState());
      var organizationRole = await _organizationRepository.organizationRole();
      var hasEdit = await _roleCurrentScopesCubit.checkScope(
        OrganizationRoleState.scope,
      );
      emit.call(
        OrganizationRoleLoadedState(
          organization: organizationRole,
          hasEdit: hasEdit,
        ),
      );
    });
    on<OrganizationRoleErrorEvent>((event, emit) async {
      emit.call(OrganizationRoleErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(OrganizationRoleErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
