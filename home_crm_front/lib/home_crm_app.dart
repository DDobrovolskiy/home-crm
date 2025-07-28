import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:home_crm_front/domain/support/redux/store/store.dart';
import 'package:home_crm_front/theme/theme.dart';

import 'domain/support/redux/state/app_state.dart';
import 'domain/support/router/roters.dart';

class HomeCrmApp extends StatelessWidget {
  const HomeCrmApp({super.key, required this.appState});

  final AppState appState;

  @override
  Widget build(BuildContext context) {
    debugPrint('Creating HomeCrmApp at timestamp: ${DateTime.now()}');
    return StoreProvider<AppState>(
      store: createStore(appState),
      child: MaterialApp(
        title: 'homeCRM',
        theme: getApplicationTheme(),
        // Светлая тема
        darkTheme: getDarkApplicationTheme(),
        // Темная тема
        themeMode: ThemeMode.system,
        navigatorKey: NavigatorHolder.navigatorKey,
        // По умолчанию используем систему устройства
        initialRoute: appState.isLogged() ? RoutersApp.home
            : RoutersApp.login,
        routes: RoutersApp.routes,
      ),
    );
  }
}
