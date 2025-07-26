import 'package:flutter/material.dart';
import 'package:home_crm_front/router/router.dart';
import 'package:home_crm_front/theme/theme.dart';

class CrmWeb extends StatelessWidget {
  const CrmWeb({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Creating CrmWeb at timestamp: ${DateTime.now()}');
    return MaterialApp(
      title: 'homeCRM',
      theme: getApplicationTheme(), // Светлая тема
      darkTheme: getDarkApplicationTheme(), // Темная тема
      themeMode: ThemeMode.system, // По умолчанию используем систему устройства
      // onGenerateRoute: (settings) => generateRoute(settings),
      routes: routes,
    );
  }
}