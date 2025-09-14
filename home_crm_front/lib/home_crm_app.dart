import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/authentication/bloc/auth_bloc.dart';
import 'package:home_crm_front/domain/sub/education/test/repository/test_repository.dart';
import 'package:home_crm_front/domain/sub/employee/bloc/employee_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/repository/employee_repository.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_role_bloc.dart';
import 'package:home_crm_front/domain/sub/role/bloc/role_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/role/cubit/role_current_scopes.dart';
import 'package:home_crm_front/domain/sub/role/repository/role_repository.dart';
import 'package:home_crm_front/domain/sub/scope/bloc/scope_bloc.dart';
import 'package:home_crm_front/domain/sub/scope/repository/scope_repository.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/domain/support/token_service.dart';
import 'package:home_crm_front/theme/theme.dart';

import 'domain/sub/authentication/repository/auth_repository.dart';
import 'domain/sub/education/test/bloc/test_edit_bloc.dart';
import 'domain/sub/organization/bloc/organization_bloc.dart';
import 'domain/sub/organization/bloc/organization_edit_bloc.dart';
import 'domain/sub/organization/bloc/organization_test_bloc.dart';
import 'domain/sub/organization/repository/organization_repository.dart';
import 'domain/sub/role/bloc/role_current.dart';
import 'domain/sub/user/bloc/user_bloc.dart';
import 'domain/sub/user/repository/user_repository.dart';
import 'domain/support/router/roters.dart';
import 'main.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => AppRouter());
  //Repositories
  GetIt.instance.registerSingleton(TokenService());
  GetIt.instance.registerSingleton(AuthRepository());
  GetIt.instance.registerSingleton(UserRepository());
  GetIt.instance.registerSingleton(OrganizationRepository());
  GetIt.instance.registerSingleton(EmployeeRepository());
  GetIt.instance.registerSingleton(RoleRepository());
  GetIt.instance.registerSingleton(ScopeRepository());
  GetIt.instance.registerSingleton(TestRepository());
  //Cubits
  GetIt.instance.registerSingleton(RoleCurrentScopesCubit());
  //Bloc
  GetIt.instance.registerSingleton(AuthBloc());
  GetIt.instance.registerSingleton(UserBloc());

  GetIt.instance.registerSingleton(UserOrganizationBloc());
  GetIt.instance.registerSingleton(UserEmployeeBloc());

  GetIt.instance.registerSingleton(OrganizationBloc());
  GetIt.instance.registerSingleton(OrganizationEditBloc());
  GetIt.instance.registerSingleton(OrganizationEmployeeBloc());
  GetIt.instance.registerSingleton(OrganizationRoleBloc());
  GetIt.instance.registerSingleton(OrganizationTestBloc());

  GetIt.instance.registerSingleton(EmployeeEditBloc());

  GetIt.instance.registerSingleton(RoleCurrentBloc());
  GetIt.instance.registerSingleton(RoleEditBloc());

  GetIt.instance.registerSingleton(ScopeBloc());

  GetIt.instance.registerSingleton(TestEditBloc());
}

Future<bool> resetBlocs() async {
  debugPrint('resetBlocs');
  await GetIt.instance.reset(); // Удаляет все зарегистрированные объекты
  main(); // Повторно регистрирует BLoC'и
  return true;
}

class HomeCrmApp extends StatelessWidget {
  HomeCrmApp({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Creating HomeCrmApp at timestamp: ${DateTime.now()}');
    return MultiBlocProvider(
      providers: [
        BlocProvider<RoleCurrentScopesCubit>.value(
          value: GetIt.instance.get<RoleCurrentScopesCubit>(),
        ),
        BlocProvider<AuthBloc>.value(value: GetIt.instance.get<AuthBloc>()),
        BlocProvider<UserBloc>.value(value: GetIt.instance.get<UserBloc>()),
        BlocProvider<UserOrganizationBloc>.value(
          value: GetIt.instance.get<UserOrganizationBloc>(),
        ),
        BlocProvider<UserEmployeeBloc>.value(
          value: GetIt.instance.get<UserEmployeeBloc>(),
        ),
        BlocProvider<OrganizationBloc>.value(
          value: GetIt.instance.get<OrganizationBloc>(),
        ),
        BlocProvider<OrganizationEditBloc>.value(
          value: GetIt.instance.get<OrganizationEditBloc>(),
        ),
        BlocProvider<OrganizationEmployeeBloc>.value(
          value: GetIt.instance.get<OrganizationEmployeeBloc>(),
        ),
        BlocProvider<OrganizationRoleBloc>.value(
          value: GetIt.instance.get<OrganizationRoleBloc>(),
        ),
        BlocProvider<OrganizationTestBloc>.value(
          value: GetIt.instance.get<OrganizationTestBloc>(),
        ),
        BlocProvider<EmployeeEditBloc>.value(
          value: GetIt.instance.get<EmployeeEditBloc>(),
        ),
        BlocProvider<RoleCurrentBloc>.value(
          value: GetIt.instance.get<RoleCurrentBloc>(),
        ),
        BlocProvider<RoleEditBloc>.value(
          value: GetIt.instance.get<RoleEditBloc>(),
        ),
        BlocProvider<ScopeBloc>.value(value: GetIt.instance.get<ScopeBloc>()),
        BlocProvider<TestEditBloc>.value(
          value: GetIt.instance.get<TestEditBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'homeCRM',
        theme: getApplicationTheme(),
        // Светлая тема
        darkTheme: getDarkApplicationTheme(),
        // Темная тема
        themeMode: ThemeMode.light,
        routerConfig: GetIt.instance.get<AppRouter>().config(
          // navigatorObservers:
        ),
      ),
    );
  }
}
