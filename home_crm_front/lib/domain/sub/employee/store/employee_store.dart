import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/aggregate/employee_aggregate.dart';
import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';

import '../../../support/port/port.dart';
import '../../../support/service/loaded.dart';
import '../../organization/repository/organization_repository.dart';

class EmployeeStore extends IsHasError {
  bool load = false;
  PortException? error;
  final Map<int, EmployeeAggregate> employees = {};

  late final OrganizationRepository _organizationRepository = GetIt.I
      .get<OrganizationRepository>();

  Future<bool> refresh(Loaded loaded) async {
    if (loaded.needLoad(this)) {
      try {
        var organizationEmployee = await _organizationRepository
            .organizationEmployee();
        organizationEmployee?.employees.forEach((e) {
          employees[e.id] = EmployeeAggregate(
            id: e.id,
            userId: e.user.id,
            roleId: e.role.id,
          );
        });
        load = true;
      } catch (e) {
        error = Port.errorHandler(e);
      }
    }
    return true;
  }

  Future<EmployeeAggregate?> get(int id) async {
    var result = await refresh(Loaded.ifNotLoad);
    return employees[id];
  }

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return load;
  }
}
