import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_employee_bloc.dart';
import 'package:home_crm_front/domain/sub/user/bloc/user_organization_bloc.dart';
import 'package:home_crm_front/theme/theme.dart';

import 'domain/sub/organization/bloc/organization_bloc.dart';
import 'domain/sub/user/bloc/user_bloc.dart';
import 'domain/support/router/roters.dart';

class HomeCrmApp extends StatelessWidget {
  HomeCrmApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    debugPrint('Creating HomeCrmApp at timestamp: ${DateTime.now()}');
    final locator = GetIt.instance;
    locator.registerLazySingleton(() => UserBloc());
    locator.registerLazySingleton(() => UserOrganizationBloc());
    locator.registerLazySingleton(() => UserEmployeeBloc());
    locator.registerLazySingleton(() => OrganizationBloc());
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(create: (context) => locator.get<UserBloc>()),
        BlocProvider<UserOrganizationBloc>(
            create: (context) => locator.get<UserOrganizationBloc>()),
        BlocProvider<UserEmployeeBloc>(
            create: (context) => locator.get<UserEmployeeBloc>()),
        BlocProvider<OrganizationBloc>(
            create: (context) => locator.get<OrganizationBloc>()),
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
