import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/authentication/bloc/auth_bloc.dart';
import 'package:home_crm_front/domain/sub/education/option/bloc/option_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/education/option/repository/option_repository.dart';
import 'package:home_crm_front/domain/sub/education/question/bloc/question_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/education/question/bloc/question_option_bloc.dart';
import 'package:home_crm_front/domain/sub/education/question/repository/question_repository.dart';
import 'package:home_crm_front/domain/sub/education/session/bloc/session_bloc.dart';
import 'package:home_crm_front/domain/sub/education/session/cubit/session_result.dart';
import 'package:home_crm_front/domain/sub/education/session/repository/session_repository.dart';
import 'package:home_crm_front/domain/sub/education/test/bloc/test_question_bloc.dart';
import 'package:home_crm_front/domain/sub/education/test/cubit/test_assign.dart';
import 'package:home_crm_front/domain/sub/education/test/repository/test_repository.dart';
import 'package:home_crm_front/domain/sub/employee/bloc/employee_edit_bloc.dart';
import 'package:home_crm_front/domain/sub/employee/bloc/employee_test_bloc.dart';
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
import 'domain/sub/organization/bloc/organization_employee_test_bloc.dart';
import 'domain/sub/organization/bloc/organization_test_bloc.dart';
import 'domain/sub/organization/repository/organization_repository.dart';
import 'domain/sub/role/bloc/role_current.dart';
import 'domain/sub/user/bloc/user_bloc.dart';
import 'domain/sub/user/repository/user_repository.dart';
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
  GetIt.I.registerSingleton(TestRepository());
  GetIt.I.registerSingleton(QuestionRepository());
  GetIt.I.registerSingleton(OptionRepository());
  GetIt.I.registerSingleton(SessionRepository());
  //Cubits
  GetIt.I.registerSingleton(RoleCurrentScopesCubit());
  GetIt.I.registerSingleton(TestAssignCubit());
  GetIt.I.registerSingleton(SessionResultCubit());
  //Bloc
  GetIt.I.registerSingleton(AuthBloc());
  GetIt.I.registerSingleton(UserBloc());

  GetIt.I.registerSingleton(UserOrganizationBloc());
  GetIt.I.registerSingleton(UserEmployeeBloc());

  GetIt.I.registerSingleton(OrganizationBloc());
  GetIt.I.registerSingleton(OrganizationEditBloc());
  GetIt.I.registerSingleton(OrganizationEmployeeBloc());
  GetIt.I.registerSingleton(OrganizationRoleBloc());
  GetIt.I.registerSingleton(OrganizationTestBloc());
  GetIt.I.registerSingleton(OrganizationEmployeeTestBloc());

  GetIt.I.registerSingleton(EmployeeEditBloc());
  GetIt.I.registerSingleton(EmployeeTestBloc());

  GetIt.I.registerSingleton(RoleCurrentBloc());
  GetIt.I.registerSingleton(RoleEditBloc());

  GetIt.I.registerSingleton(ScopeBloc());

  GetIt.I.registerSingleton(TestEditBloc());
  GetIt.I.registerSingleton(TestQuestionBloc());
  GetIt.I.registerSingleton(QuestionEditBloc());
  GetIt.I.registerSingleton(QuestionOptionBloc());
  GetIt.I.registerSingleton(OptionEditBloc());

  GetIt.I.registerSingleton(SessionBloc());
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
        BlocProvider<TestAssignCubit>.value(
          value: GetIt.I.get<TestAssignCubit>(),
        ),
        BlocProvider<SessionResultCubit>.value(
          value: GetIt.I.get<SessionResultCubit>(),
        ),
        BlocProvider<AuthBloc>.value(value: GetIt.I.get<AuthBloc>()),
        BlocProvider<UserBloc>.value(value: GetIt.I.get<UserBloc>()),
        BlocProvider<UserOrganizationBloc>.value(
          value: GetIt.I.get<UserOrganizationBloc>(),
        ),
        BlocProvider<UserEmployeeBloc>.value(
          value: GetIt.I.get<UserEmployeeBloc>(),
        ),
        BlocProvider<OrganizationBloc>.value(
          value: GetIt.I.get<OrganizationBloc>(),
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
        BlocProvider<OrganizationTestBloc>.value(
          value: GetIt.I.get<OrganizationTestBloc>(),
        ),
        BlocProvider<OrganizationEmployeeTestBloc>.value(
          value: GetIt.I.get<OrganizationEmployeeTestBloc>(),
        ),
        BlocProvider<EmployeeEditBloc>.value(
          value: GetIt.I.get<EmployeeEditBloc>(),
        ),
        BlocProvider<EmployeeTestBloc>.value(
          value: GetIt.I.get<EmployeeTestBloc>(),
        ),
        BlocProvider<RoleCurrentBloc>.value(
          value: GetIt.I.get<RoleCurrentBloc>(),
        ),
        BlocProvider<RoleEditBloc>.value(value: GetIt.I.get<RoleEditBloc>()),
        BlocProvider<ScopeBloc>.value(value: GetIt.instance.get<ScopeBloc>()),
        BlocProvider<TestEditBloc>.value(value: GetIt.I.get<TestEditBloc>()),
        BlocProvider<TestQuestionBloc>.value(
          value: GetIt.I.get<TestQuestionBloc>(),
        ),
        BlocProvider<QuestionEditBloc>.value(
          value: GetIt.I.get<QuestionEditBloc>(),
        ),
        BlocProvider<QuestionOptionBloc>.value(
          value: GetIt.I.get<QuestionOptionBloc>(),
        ),
        BlocProvider<OptionEditBloc>.value(
          value: GetIt.I.get<OptionEditBloc>(),
        ),
        BlocProvider<SessionBloc>.value(
          value: GetIt.I.get<SessionBloc>(),
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
