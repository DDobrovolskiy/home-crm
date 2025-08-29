import 'package:flutter/material.dart';
import 'package:home_crm_front/theme/theme.dart';

import 'domain/support/router/roters.dart';

class HomeCrmApp extends StatelessWidget {
  HomeCrmApp({super.key});

  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    debugPrint('Creating HomeCrmApp at timestamp: ${DateTime.now()}');
    return MaterialApp.router(
      title: 'homeCRM',
      theme: getApplicationTheme(),
      // Светлая тема
      darkTheme: getDarkApplicationTheme(),
      // Темная тема
      themeMode: ThemeMode.system,
      routerConfig: _appRouter.config(
        // navigatorObservers:
      ),
    );
  }
}
