import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_delete_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_event.dart';

import '../dto/request/employee_create_dto.dart';
import '../event/employee_edit_event.dart';
import '../repository/employee_repository.dart';
import '../state/employee_edit_state.dart';

class EmployeeEditBloc extends Bloc<EmployeeEditEvent, EmployeeEditState> {
  late final EmployeeRepository _employeeRepository = GetIt.instance
      .get<EmployeeRepository>();
  late final OrganizationEmployeeBloc _organizationEmployeeBloc = GetIt.instance
      .get<OrganizationEmployeeBloc>();

  EmployeeEditBloc()
      : super(EmployeeEditPointState(isEndEdit: false, isLoading: true)) {
    on<EmployeeEditRefreshEvent>((event, emit) async {
      _organizationEmployeeBloc.add(OrganizationEmployeeRefreshEvent());
      emit.call(EmployeeEditPointState(isEndEdit: true, isLoading: false));
    });
    on<EmployeeEditLoadEvent>((event, emit) async {
      if (event.id == null) {
        emit.call(EmployeeEditLoadedState(data: null, isOnlyWatch: false));
      } else {
        var employee = await _employeeRepository.getEmployeeLocalStorage(
            event.id!);
        //TODO Проверка прав
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
        EmployeeUpdateDto(roleId: event.roleId),
      );
      add(EmployeeEditRefreshEvent());
    });
    on<EmployeeEditDeleteEvent>((event, emit) async {
      await _employeeRepository.employeeDelete(EmployeeDeleteDto(id: event.id));
      add(EmployeeEditRefreshEvent());
    });
    on<EmployeeEditErrorEvent>((event, emit) {
      emit.call(EmployeeEditErrorState(error: event.error));
    });
  }
}
