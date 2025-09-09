import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_delete_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_update_dto.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/event/organization_employee_event.dart';
import 'package:home_crm_front/domain/support/bloc/edit/bloc/edit_bloc.dart';
import 'package:home_crm_front/domain/support/bloc/edit/event/edit_event.dart';
import 'package:home_crm_front/domain/support/bloc/edit/state/edit_state.dart';

import '../../../support/port/port.dart';
import '../dto/request/employee_create_dto.dart';
import '../dto/response/employee_dto.dart';
import '../event/employee_edit_event.dart';
import '../repository/employee_repository.dart';

class EmployeeEditBloc extends EditBloc<EmployeeEditEvent, EmployeeDto> {
  late final EmployeeRepository _employeeRepository = GetIt.instance
      .get<EmployeeRepository>();
  late final OrganizationEmployeeBloc _organizationEmployeeBloc = GetIt.instance
      .get<OrganizationEmployeeBloc>();

  @override
  void refreshOtherBloc() async {
    _organizationEmployeeBloc.add(OrganizationEmployeeRefreshEvent());
  }

  @override
  Future<void> onCreate(
    EmployeeEditEvent? data,
    Emitter<EditState<EmployeeDto>> emit,
  ) async {
    await _employeeRepository.employeeCreate(
      EmployeeCreateDto(
        name: data!.name!,
        phone: data.phone!,
        password: data.password!,
        roleId: data.roleId!,
      ),
    );
  }

  @override
  Future<void> onDelete(
    EmployeeEditEvent? data,
    Emitter<EditState<EmployeeDto>> emit,
  ) async {
    await _employeeRepository.employeeDelete(EmployeeDeleteDto(id: data!.id!));
  }

  }

  @override
  Future<void> onLoad(EmployeeEditEvent? data,
      Emitter<EditState<EmployeeDto>> emit,) async {
    if (data?.id == null) {
      emit.call(EditLoadedState(data: null, isOnlyWatch: false));
    } else {
      var employee = await _employeeRepository.getEmployeeLocalStorage(
          data!.id!);
      //TODO Проверка прав
      emit.call(EditLoadedState(data: employee, isOnlyWatch: false));
    }
  }

  @override
  Future<void> onUpdate(EmployeeEditEvent? data,
      Emitter<EditState<EmployeeDto>> emit,) async {
    await _employeeRepository.employeeUpdate(
      EmployeeUpdateDto(roleId: data!.roleId!),
    );
  }
}
