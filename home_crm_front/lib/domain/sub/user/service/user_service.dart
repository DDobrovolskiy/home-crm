import 'package:get_it/get_it.dart';

import '../../../support/service/loaded.dart';
import '../bloc/user_bloc.dart';
import '../bloc/user_employee_bloc.dart';
import '../bloc/user_organization_bloc.dart';
import '../event/user_employee_event.dart';
import '../event/user_event.dart';
import '../event/user_organization_event.dart';

class UserService {
  late final UserBloc _userBloc = GetIt.I.get<UserBloc>();
  late final UserOrganizationBloc _userOrganizationBloc = GetIt.I
      .get<UserOrganizationBloc>();
  late final UserEmployeeBloc _userEmployeeBloc = GetIt.I
      .get<UserEmployeeBloc>();

  void refreshAll(Loaded loaded) {
    refreshUser(loaded);
    refreshUserOrganization(loaded);
    refreshUserEmployee(loaded);
  }

  void refreshUser(Loaded loaded) {
    if (loaded.needLoad(_userBloc.state)) {
      _userBloc.add(UserLoadEvent());
    }
  }

  void refreshUserOrganization(Loaded loaded) {
    if (loaded.needLoad(_userOrganizationBloc.state)) {
      _userOrganizationBloc.add(UserOrganizationRefreshEvent());
    }
  }

  void refreshUserEmployee(Loaded loaded) {
    if (loaded.needLoad(_userEmployeeBloc.state)) {
      _userEmployeeBloc.add(UserEmployeeLoadEvent());
    }
  }
}
