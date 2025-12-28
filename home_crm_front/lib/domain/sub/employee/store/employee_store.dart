import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/aggregate/employee_aggregate.dart';
import 'package:home_crm_front/domain/sub/user/aggregate/user_aggregate.dart';

import '../../../support/components/load/custom_load.dart';
import '../../../support/components/store/store.dart';
import '../../../support/service/loaded.dart';
import '../../organization/repository/organization_repository.dart';

class EmployeeStore extends Store<EmployeeAggregate> {
  late final OrganizationRepository _organizationRepository = GetIt.I
      .get<OrganizationRepository>();

  LoadStore<List<EmployeeAggregate>> getAll() {
    return LoadStore(
      value: () async => (await refresh(
        Loaded.ifNotLoad,
      )).entries.map((e) => e.value).toList(),
      callback: loadCallback,
    );
  }

  LoadStore<Map<int, EmployeeAggregate>> getAllMap() {
    return LoadStore(
      value: () async =>
      (await refresh(
        Loaded.ifNotLoad,
      )),
      callback: loadCallback,
    );
  }

  @override
  Future<void> loadData() async {
    var organizationEmployee = await _organizationRepository
        .organizationEmployee();
    organizationEmployee?.employees.forEach((e) {
      data[e.id] = EmployeeAggregate(
        id: e.id,
        user: UserAggregate(
          id: e.user.id,
          name: e.user.name,
          phone: e.user.phone,
        ),
        roleId: e.role.id,
      );
    });
  }

  @override
  Future<List<EmployeeAggregate>?> loadDataIds(Set<int> ids) {
    // TODO: implement loadDataIds
    throw UnimplementedError();
  }

  @override
  Future<bool?> deleteInBackend(Set<int> ids) {
    // TODO: implement deleteInBackend
    throw UnimplementedError();
  }
}
