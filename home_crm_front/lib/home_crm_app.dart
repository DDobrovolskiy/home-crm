import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/authentication/bloc/auth_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/repository/employee_repository.dart';
import 'package:home_crm_front/domain/sub/employee/service/employee_service.dart';
import 'package:home_crm_front/domain/sub/employee/store/employee_store.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/bloc/organization_role_bloc.dart';
import 'package:home_crm_front/domain/sub/organization/service/organization_service.dart';
import 'package:home_crm_front/domain/sub/role/cubit/role_current_scopes.dart';
import 'package:home_crm_front/domain/sub/role/repository/role_repository.dart';
import 'package:home_crm_front/domain/sub/scope/bloc/scope_bloc.dart';
import 'package:home_crm_front/domain/sub/scope/repository/scope_repository.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/domain/sub/user/service/user_service.dart';
import 'package:home_crm_front/domain/support/components/content/ContentList.dart';
import 'package:home_crm_front/domain/support/token_service.dart';
import 'package:home_crm_front/theme/theme.dart';

import 'domain/sub/authentication/repository/auth_repository.dart';
import 'domain/sub/education/store/education_store.dart';
import 'domain/sub/organization/bloc/organization_bloc.dart';
import 'domain/sub/organization/bloc/organization_edit_bloc.dart';
import 'domain/sub/organization/repository/organization_repository.dart';
import 'domain/sub/role/bloc/role_current.dart';
import 'domain/sub/role/service/role_service.dart';
import 'domain/sub/scope/service/scope_service.dart';
import 'domain/sub/user/bloc/user_bloc.dart';
import 'domain/sub/user/repository/user_repository.dart';
import 'domain/support/components/callback/NavBarCallBack.dart';
import 'domain/support/router/roters.dart';
import 'main.dart';

void setupLocator() {
  GetIt.I.registerLazySingleton(() => AppRouter());
  //Repositories
  GetIt.I.registerSingleton(TokenService());
  GetIt.I.registerSingleton(AuthRepository());
  GetIt.I.registerSingleton(UserRepository());
  GetIt.I.registerSingleton(OrganizationRepository());
  GetIt.I.registerSingleton(EmployeeRepository());
  GetIt.I.registerSingleton(RoleRepository());
  GetIt.I.registerSingleton(ScopeRepository());

  //Cubits
  GetIt.I.registerSingleton(RoleCurrentScopesCubit());
  //Bloc
  GetIt.I.registerSingleton(AuthBloc());
  GetIt.I.registerSingleton(UserBloc());

  GetIt.I.registerSingleton(UserOrganizationBloc());
  GetIt.I.registerSingleton(UserEmployeeBloc());

  GetIt.I.registerSingleton(OrganizationCurrentBloc());
  GetIt.I.registerSingleton(OrganizationEditBloc());
  GetIt.I.registerSingleton(OrganizationEmployeeBloc());
  GetIt.I.registerSingleton(OrganizationRoleBloc());

  GetIt.I.registerSingleton(RoleCurrentBloc());

  GetIt.I.registerSingleton(ScopeBloc());

  GetIt.I.registerSingleton(EmployeeStore());
  GetIt.I.registerSingleton(EducationStore());

  //Service
  GetIt.I.registerSingleton(UserService());
  GetIt.I.registerSingleton(ScopeService());
  GetIt.I.registerSingleton(OrganizationService());
  GetIt.I.registerSingleton(RoleService());
  GetIt.I.registerSingleton(EmployeeService());

  //callback
  GetIt.I.registerLazySingleton(() => SheetElementAddCallback());
  GetIt.I.registerLazySingleton(() => SheetElementSelectCallback());
  GetIt.I.registerLazySingleton(() => SheetElementDeleteCallback());

  //pages
  // GetIt.I.registerLazySingleton(() => SheetBar());
  GetIt.I.registerLazySingleton(() => ContentList());
}

Future<bool> resetBlocs() async {
  debugPrint('resetBlocs');
  await GetIt.I.reset(); // Удаляет все зарегистрированные объекты
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
          value: GetIt.I.get<RoleCurrentScopesCubit>(),
        ),
        BlocProvider<AuthBloc>.value(value: GetIt.I.get<AuthBloc>()),
        BlocProvider<UserBloc>.value(value: GetIt.I.get<UserBloc>()),
        BlocProvider<UserOrganizationBloc>.value(
          value: GetIt.I.get<UserOrganizationBloc>(),
        ),
        BlocProvider<UserEmployeeBloc>.value(
          value: GetIt.I.get<UserEmployeeBloc>(),
        ),
        BlocProvider<OrganizationCurrentBloc>.value(
          value: GetIt.I.get<OrganizationCurrentBloc>(),
        ),
        BlocProvider<OrganizationEditBloc>.value(
          value: GetIt.I.get<OrganizationEditBloc>(),
        ),
        BlocProvider<OrganizationEmployeeBloc>.value(
          value: GetIt.I.get<OrganizationEmployeeBloc>(),
        ),
        BlocProvider<OrganizationRoleBloc>.value(
          value: GetIt.I.get<OrganizationRoleBloc>(),
        ),
        BlocProvider<RoleCurrentBloc>.value(
          value: GetIt.I.get<RoleCurrentBloc>(),
        ),
        BlocProvider<ScopeBloc>.value(value: GetIt.instance.get<ScopeBloc>()),
      ],
      child: MaterialApp.router(
        title: 'homeCRM',
        theme: getApplicationTheme(),
        // Светлая тема
        darkTheme: getDarkApplicationTheme(),
        // Темная тема
        themeMode: ThemeMode.dark,
        routerConfig: GetIt.instance.get<AppRouter>().config(
          // navigatorObservers:
        ),
        // scrollBehavior: MyCustomScrollBehavior(),
      ),
    );
  }
}

// class MyCustomScrollBehavior extends MaterialScrollBehavior {
//   // Override behavior methods and getters like dragDevices
//   @override
//   Set<PointerDeviceKind> get dragDevices =>
//       {
//         PointerDeviceKind.touch,
//         PointerDeviceKind.mouse,
//         PointerDeviceKind.trackpad,
//         PointerDeviceKind.stylus,
//         PointerDeviceKind.unknown,
//         // etc.
//       };
// }