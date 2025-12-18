import 'package:home_crm_front/domain/sub/employee/dto/request/employee_create_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_delete_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/request/employee_update_dto.dart';
import 'package:home_crm_front/domain/sub/employee/dto/response/employee_dto.dart';

import '../../../support/port/port.dart';

class EmployeeRepository {
  final String _path = 'employee';

  Future<EmployeeDto?> getEmployeeLocalStorage(int id) {
    return Port.get(
      'employee/${id}',
      (j) => EmployeeDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<EmployeeDto?> getEmployee(int id) {
    return Port.get(
      'employee/${id}',
      (j) => EmployeeDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<EmployeeDto?> employeeCreate(EmployeeCreateDto dto) {
    return Port.post(
      _path,
      dto.toJson(),
      (j) => EmployeeDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<EmployeeDto?> employeeUpdate(EmployeeUpdateDto dto) {
    return Port.put(
      _path,
      dto.toJson(),
      (j) => EmployeeDto.fromJson(j as Map<String, dynamic>),
    );
  }

  Future<int?> employeeDelete(EmployeeDeleteDto dto) {
    return Port.delete(_path, dto.toJson(), (j) => j as int);
  }

}
