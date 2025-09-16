import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/repository/organization_repository.dart';

import '../../../support/port/port.dart';
import '../../role/cubit/role_current_scopes.dart';
import '../event/organization_employee_test_event.dart';
import '../state/organization_employee_test_state.dart';

class OrganizationEmployeeTestBloc
    extends Bloc<OrganizationEmployeeTestEvent, OrganizationEmployeeTestState> {
  late final OrganizationRepository _organizationRepository = GetIt.I
      .get<OrganizationRepository>();
  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.I
      .get<RoleCurrentScopesCubit>();

  OrganizationEmployeeTestBloc() : super(OrganizationEmployeeTestInitState()) {
    on<OrganizationEmployeeTestRefreshEvent>((event, emit) async {
      emit.call(OrganizationEmployeeTestInitState());
      var organizationTest = await _organizationRepository
          .organizationEmployeeTest();
      var hasEdit = await _roleCurrentScopesCubit.checkScope(
        OrganizationEmployeeTestState.scope,
      );
      emit.call(
        OrganizationEmployeeTestLoadedState(
          organization: organizationTest,
          hasEdit: hasEdit,
        ),
      );
    });
    on<OrganizationEmployeeTestErrorEvent>((event, emit) async {
      emit.call(OrganizationEmployeeTestErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(OrganizationEmployeeTestErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
