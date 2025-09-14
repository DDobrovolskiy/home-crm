import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_delete_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_event.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_role_event.dart';
import 'package:home_crm_front/domain/support/widgets/stamp.dart';

import '../../../support/port/port.dart';
import '../../organization/bloc/organization_role_bloc.dart';
import '../../role/cubit/role_current_scopes.dart';
import '../dto/request/employee_create_dto.dart';
import '../event/employee_edit_event.dart';
import '../repository/employee_repository.dart';
import '../state/employee_edit_state.dart';

class EmployeeEditBloc extends Bloc<EmployeeEditEvent, EmployeeEditState> {
  late final EmployeeRepository _employeeRepository = GetIt.instance
      .get<EmployeeRepository>();
  late final OrganizationEmployeeBloc _organizationEmployeeBloc = GetIt.instance
      .get<OrganizationEmployeeBloc>();
  late final OrganizationRoleBloc _organizationRoleBloc = GetIt.instance
      .get<OrganizationRoleBloc>();
  late final RoleCurrentScopesCubit _roleCurrentScopesCubit = GetIt.I
      .get<RoleCurrentScopesCubit>();

  EmployeeEditBloc()
    : super(EmployeeEditPointState(isEndEdit: false, isLoading: true)) {
    on<EmployeeEditRefreshEvent>((event, emit) async {
      _organizationEmployeeBloc.add(OrganizationEmployeeRefreshEvent());
      _organizationRoleBloc.add(OrganizationRoleRefreshEvent());
      emit.call(EmployeeEditPointState(isEndEdit: true, isLoading: false));
    });
    on<EmployeeEditLoadEvent>((event, emit) async {
      emit.call(EmployeeEditPointState(isEndEdit: false, isLoading: true));
      var bool = await _roleCurrentScopesCubit.checkScopeNoSafe(
        EmployeeEditState.scope,
      );
      if (event.id == null) {
        emit.call(EmployeeEditLoadedState(data: null, isOnlyWatch: false));
      } else {
        var employee = await _employeeRepository.getEmployeeLocalStorage(
          event.id!,
        );
        emit.call(EmployeeEditLoadedState(data: employee, isOnlyWatch: false));
      }
    });
    on<EmployeeEditCreateEvent>((event, emit) async {
      await _employeeRepository.employeeCreate(
        EmployeeCreateDto(
          name: event.name,
          phone: event.phone,
          password: event.password,
          roleId: event.roleId,
        ),
      );
      add(EmployeeEditRefreshEvent());
    });
    on<EmployeeEditUpdateEvent>((event, emit) async {
      await _employeeRepository.employeeUpdate(
        EmployeeUpdateDto(id: event.id, roleId: event.roleId),
      );
      add(EmployeeEditRefreshEvent());
    });
    on<EmployeeEditDeleteEvent>((event, emit) async {
      await _employeeRepository.employeeDelete(EmployeeDeleteDto(id: event.id));
      add(EmployeeEditRefreshEvent());
    });
    on<EmployeeEditErrorEvent>((event, emit) {
      Stamp.showTemporarySnackbar(null, event.error.message);
      emit.call(EmployeeEditErrorState(error: event.error));
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    final e = Port.errorHandler(error, stackTrace);
    add(EmployeeEditErrorEvent(error: e));
    super.onError(error, stackTrace);
  }
}
