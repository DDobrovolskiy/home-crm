import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/education/test/dto/request/test_assign_dto.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_test_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_test_event.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_test_event.dart';
import 'package:home_crm_front/domain/sub/scope/scope.dart';

import '../../../organization/bloc/organization_employee_test_bloc.dart';
import '../../../role/cubit/role_current_scopes.dart';
import '../repository/test_repository.dart';
import '../state/test_assign_state.dart';

class TestAssignCubit extends Cubit<TestAssignState> {
  TestAssignCubit() : super(TestAssignInitState());

  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.instance
      .get<RoleCurrentScopesCubit>();
  late final TestRepository _testRepository = GetIt.I.get<TestRepository>();
  late final OrganizationEmployeeTestBloc _organizationEmployeeTestBloc = GetIt
      .I
      .get<OrganizationEmployeeTestBloc>();
  late final OrganizationTestBloc _organizationTestBloc = GetIt.I
      .get<OrganizationTestBloc>();

  void assignTest(int testId, int employeeId) async {
    var hasEdit = await _roleCurrentScopesCubit.checkScope(
      ScopeType.TEST_CREATE,
    );
    var value = await _testRepository.assign(
      TestAssignDto(testId: testId, employeeId: employeeId),
    );
    _organizationEmployeeTestBloc.add(OrganizationEmployeeTestRefreshEvent());
    _organizationTestBloc.add(OrganizationTestRefreshEvent());
  }

  void unassignTest(int testId, int employeeId) async {
    var hasEdit = await _roleCurrentScopesCubit.checkScope(
      ScopeType.TEST_CREATE,
    );
    var value = await _testRepository.unassign(
      TestAssignDto(testId: testId, employeeId: employeeId),
    );
    _organizationEmployeeTestBloc.add(OrganizationEmployeeTestRefreshEvent());
    _organizationTestBloc.add(OrganizationTestRefreshEvent());
  }
}
