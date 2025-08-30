import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/domain/support/token_service.dart';
import 'package:home_crm_front/theme/theme.dart';

import 'domain/sub/organization/bloc/organization_bloc.dart';
import 'domain/sub/organization/bloc/organization_edit_bloc.dart';
import 'domain/sub/organization/repository/organization_repository.dart';
import 'domain/sub/user/bloc/user_bloc.dart';
import 'domain/support/router/roters.dart';

void setupLocator() {
  GetIt.instance.registerLazySingleton(() => TokenService());
  GetIt.instance.registerLazySingleton(() => OrganizationRepository());

  GetIt.instance.registerLazySingleton(() => UserBloc());
  GetIt.instance.registerLazySingleton(() => UserOrganizationBloc());
  GetIt.instance.registerLazySingleton(() => UserEmployeeBloc());
  GetIt.instance.registerLazySingleton(() => OrganizationBloc());
  GetIt.instance.registerLazySingleton(() => OrganizationEditBloc());
}

class HomeCrmApp extends StatelessWidget {
  HomeCrmApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    debugPrint('Creating HomeCrmApp at timestamp: ${DateTime.now()}');
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
            create: (context) => GetIt.instance.get<UserBloc>()),
        BlocProvider<UserOrganizationBloc>(
            create: (context) => GetIt.instance.get<UserOrganizationBloc>()),
        BlocProvider<UserEmployeeBloc>(
            create: (context) => GetIt.instance.get<UserEmployeeBloc>()),
        BlocProvider<OrganizationBloc>(
            create: (context) => GetIt.instance.get<OrganizationBloc>()),
        BlocProvider<OrganizationEditBloc>(
            create: (context) => GetIt.instance.get<OrganizationEditBloc>()),
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
