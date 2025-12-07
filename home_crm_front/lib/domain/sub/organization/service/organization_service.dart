import 'package:get_it/get_it.dart';

import '../bloc/organization_bloc.dart';
import '../bloc/organization_employee_bloc.dart';
import '../state/organization_state.dart';

class OrganizationService {
  late final OrganizationBloc _organizationBloc = GetIt.instance
      .get<OrganizationBloc>();
  late final OrganizationEmployeeBloc _organizationEmployeeBloc = GetIt.instance
      .get<OrganizationEmployeeBloc>();

  bool isOwner() {
    if (_organizationBloc.state is OrganizationUnSelectedState) {
      _organizationBloc.refresh();
    }
  }
}
