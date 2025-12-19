import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/employee/aggregate/employee_aggregate.dart';
import 'package:home_crm_front/domain/support/exceptions/exceptions.dart';
import 'package:synchronized/synchronized.dart';

import '../../../support/components/load/custom_load.dart';
import '../../../support/port/port.dart';
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
  Future<Map<int, EmployeeAggregate>> _loadData() async {
    var organizationEmployee = await _organizationRepository
        .organizationEmployee();
    organizationEmployee?.employees.forEach((e) {
      employees[e.id] = EmployeeAggregate(
        id: e.id,
        userId: e.user.id,
        roleId: e.role.id,
      );
    });
    return employees;
  }
}

abstract class Store<T> extends IsHasError {
  bool load = false;
  PortException? error;
  LoadCallback loadCallback = LoadCallback();
  late Map<int, T> data = {};
  final _lock = Lock();

  Future<Map<int, T>> refresh(Loaded loaded) async {
    return await _lock.synchronized(() async {
      if (loaded.needLoad(this)) {
        try {
          load = true;
          data = await _loadData();
          if (loaded != Loaded.ifNotLoad) {
            loadCallback.call();
          }
        } catch (e) {
          error = Port.errorHandler(e);
        }
      }
      return data;
    });
  }

  Future<Map<int, T>> _loadData();

  @override
  PortException? getError() {
    return error;
  }

  @override
  bool loaded() {
    return load;
  }
}
