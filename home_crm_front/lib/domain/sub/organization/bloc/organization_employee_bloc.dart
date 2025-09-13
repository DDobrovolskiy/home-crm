import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/repository/organization_repository.dart';

import '../../../support/port/port.dart';
import '../../role/cubit/role_current_scopes.dart';
import '../event/organization_employee_event.dart';
import '../state/organization_employee_state.dart';

class OrganizationEmployeeBloc
    extends Bloc<OrganizationEmployeeEvent, OrganizationEmployeeState> {
  late final OrganizationRepository _repository = GetIt.instance
      .get<OrganizationRepository>();
  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.instance
      .get<RoleCurrentScopesCubit>();

  OrganizationEmployeeBloc() : super(OrganizationEmployeeInitState()) {
    on<OrganizationEmployeeRefreshEvent>((event, emit) async {
      emit.call(OrganizationEmployeeInitState());
      var organizationEmployee = await _repository.organizationEmployee();
      var hasEdit = await _roleCurrentScopesCubit.checkScope(
          OrganizationEmployeeState.scope);
      emit.call(
        OrganizationEmployeeLoadedState(
            organization: organizationEmployee, hasEdit: hasEdit),
      );
    });
    on<OrganizationEmployeeErrorEvent>((event, emit) async {
      emit.call(OrganizationEmployeeErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(OrganizationEmployeeErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
