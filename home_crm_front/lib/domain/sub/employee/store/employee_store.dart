import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/aggregate/employee_aggregate.dart';
import 'package:home_crm_front/domain/sub/user/aggregate/user_aggregate.dart';

import '../../../support/components/load/custom_load.dart';
import '../../../support/components/store/store.dart';
import '../../../support/service/loaded.dart';
import '../../organization/repository/organization_repository.dart';

class EmployeeStore extends Store<EmployeeAggregate> {
  final Map<int, EmployeeAggregate> employees = {};

  late final OrganizationRepository _organizationRepository = GetIt.I
      .get<OrganizationRepository>();

  LoadStore<EmployeeAggregate?> get(int id) {
    return LoadStore(
      value: () async => (await refresh(Loaded.ifNotLoad))[id],
      callback: loadCallback,
    );
  }

  @override
  Future<Map<int, EmployeeAggregate>> loadData() async {
    var organizationEmployee = await _organizationRepository
        .organizationEmployee();
    organizationEmployee?.employees.forEach((e) {
      employees[e.id] = EmployeeAggregate(
        id: e.id,
        user: UserAggregate(
            id: e.user.id, name: e.user.name, phone: e.user.phone),
        roleId: e.role.id,
      );
    });

    return employees;
  }
}
