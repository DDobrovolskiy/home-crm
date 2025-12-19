import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';

import '../../../support/service/loaded.dart';
import '../dto/request/employee_create_dto.dart';
import '../dto/request/employee_delete_dto.dart';
import '../dto/request/employee_update_dto.dart';
import '../dto/response/employee_dto.dart';
import '../repository/employee_repository.dart';
import '../store/employee_store.dart';

class EmployeeService {
  late final EmployeeRepository _employeeRepository = GetIt.I
      .get<EmployeeRepository>();
  late final OrganizationService _organizationService = GetIt.I
      .get<OrganizationService>();
  late final EmployeeStore _employeeStore = GetIt.I.get<EmployeeStore>();

  Future<EmployeeDto?> addEmployee(EmployeeCreateDto employee) async {
    EmployeeDto? result = await _employeeRepository.employeeCreate(employee);
    _organizationService.refreshOrganizationEmployees(Loaded.ifLoad);
    return result;
  }

  Future<EmployeeDto?> updateEmployee(EmployeeUpdateDto employee) async {
    EmployeeDto? result = await _employeeRepository.employeeUpdate(employee);
    _organizationService.refreshOrganizationEmployees(Loaded.ifLoad);
    return result;
  }

  Future<bool> deleteEmployee(EmployeeDeleteDto employee) async {
    await _employeeRepository.employeeDelete(employee);
    _organizationService.refreshOrganizationEmployees(Loaded.ifLoad);
    return true;
  }
}
