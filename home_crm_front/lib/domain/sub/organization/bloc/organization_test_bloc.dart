import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/repository/organization_repository.dart';

import '../../../support/port/port.dart';
import '../../role/cubit/role_current_scopes.dart';
import '../event/organization_test_event.dart';
import '../state/organization_test_state.dart';

class OrganizationTestBloc
    extends Bloc<OrganizationTestEvent, OrganizationTestState> {
  late final OrganizationRepository _organizationRepository = GetIt.instance
      .get<OrganizationRepository>();
  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.instance
      .get<RoleCurrentScopesCubit>();

  OrganizationTestBloc() : super(OrganizationTestInitState()) {
    on<OrganizationTestRefreshEvent>((event, emit) async {
      emit.call(OrganizationTestInitState());
      var organizationTest = await _organizationRepository.organizationTest();
      emit.call(
        OrganizationTestLoadedState(
          organization: organizationTest,
        ),
      );
    });
    on<OrganizationTestErrorEvent>((event, emit) async {
      emit.call(OrganizationTestErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(OrganizationTestErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
