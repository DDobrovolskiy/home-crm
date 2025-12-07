import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../../support/service/loaded.dart';
import '../../../support/widgets/stamp.dart';
import '../../scope/scope.dart';
import '../bloc/organization_bloc.dart';
import '../bloc/organization_employee_bloc.dart';
import '../bloc/organization_role_bloc.dart';
import '../dto/response/organization_role_dto.dart';
import '../event/organization_role_event.dart';
import '../state/organization_role_state.dart';

class OrganizationCurrentService {
  static ScopeType scope = ScopeType.ORGANIZATION_UPDATE;

  late final OrganizationCurrentBloc _organizationBloc = GetIt.instance
      .get<OrganizationCurrentBloc>();
  late final OrganizationEmployeeBloc _organizationEmployeeBloc = GetIt.instance
      .get<OrganizationEmployeeBloc>();
  late final OrganizationRoleBloc _organizationRoleBloc = GetIt.instance
      .get<OrganizationRoleBloc>();

  void refreshOrganizationRoles(Loaded loaded) {
    if (loaded.needLoad(_organizationRoleBloc.state)) {
      _organizationRoleBloc.add(OrganizationRoleRefreshEvent());
    }
  }

  Widget organizationRole(
    BuildContext context,
    Widget Function(BuildContext context, OrganizationRoleDto organization)
    builder,
  ) {
    return BlocConsumer<OrganizationRoleBloc, OrganizationRoleState>(
      listener: (context, state) {
        if (state is OrganizationRoleErrorState) {
          Stamp.showTemporarySnackbar(context, state.error.message);
        }
      },
      builder: (context, state) {
        if (!state.loaded()) {
          return Stamp.loadWidget(context);
        } else if (state.getBody() != null) {
          return builder(context, state.getBody()!);
        } else {
          return Stamp.errorWidget(context);
        }
      },
    );
  }
}
