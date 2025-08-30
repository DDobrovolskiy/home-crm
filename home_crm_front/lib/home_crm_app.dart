import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/authentication/bloc/auth_bloc.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/domain/support/token_service.dart';
import 'package:home_crm_front/theme/theme.dart';

import 'domain/sub/authentication/repository/auth_repository.dart';
import 'domain/sub/organization/bloc/organization_bloc.dart';
import 'domain/sub/organization/bloc/organization_edit_bloc.dart';
import 'domain/sub/organization/repository/organization_repository.dart';
import 'domain/sub/user/bloc/user_bloc.dart';
import 'domain/sub/user/repository/user_repository.dart';
import 'domain/support/router/roters.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => TokenService());
  GetIt.instance.registerLazySingleton(() => AuthRepository());
  GetIt.instance.registerLazySingleton(() => UserRepository());
  GetIt.instance.registerLazySingleton(() => OrganizationRepository());

  GetIt.instance.registerLazySingleton(() => AuthBloc());
  GetIt.instance.registerLazySingleton(() => UserBloc());
  GetIt.instance.registerLazySingleton(() => UserOrganizationBloc());
  GetIt.instance.registerLazySingleton(() => UserEmployeeBloc());
  GetIt.instance.registerLazySingleton(() => OrganizationBloc());
  GetIt.instance.registerLazySingleton(() => OrganizationEditBloc());
}

Future<void> resetBlocs() async {
  await GetIt.instance.reset(); // Удаляет все зарегистрированные объекты
  setupLocator(); // Повторно регистрирует BLoC'и
}

class HomeCrmApp extends StatelessWidget {
  HomeCrmApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    debugPrint('Creating HomeCrmApp at timestamp: ${DateTime.now()}');
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: GetIt.instance.get<AuthBloc>()),
        BlocProvider<UserBloc>.value(value: GetIt.instance.get<UserBloc>()),
        BlocProvider<UserOrganizationBloc>.value(
            value: GetIt.instance.get<UserOrganizationBloc>()),
        BlocProvider<UserEmployeeBloc>.value(
            value: GetIt.instance.get<UserEmployeeBloc>()),
        BlocProvider<OrganizationBloc>.value(
            value: GetIt.instance.get<OrganizationBloc>()),
        BlocProvider<OrganizationEditBloc>.value(
            value: GetIt.instance.get<OrganizationEditBloc>()),
      ],
      child: MaterialApp.router(
        title: 'homeCRM',
        theme: getApplicationTheme(),
        // Светлая тема
        darkTheme: getDarkApplicationTheme(),
        // Темная тема
        themeMode: ThemeMode.system,
        routerConfig: _appRouter.config(
          // navigatorObservers:
        ),
      ),
    );
  }
}
