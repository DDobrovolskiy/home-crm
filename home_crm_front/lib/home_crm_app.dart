import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:home_crm_front/domain/support/redux/store/init_store.dart';
import 'package:home_crm_front/theme/theme.dart';

import 'domain/support/redux/state/app_state.dart';
import 'domain/support/router/roters.dart';

class HomeCrmApp extends StatelessWidget {
  const HomeCrmApp({super.key, required this.authToken});

  final String? authToken;

  @override
  Widget build(BuildContext context) {
    debugPrint('Creating HomeCrmApp at timestamp: ${DateTime.now()}');
    final store = createStore(authToken, context);
    final storeProvider = StoreProvider<AppState>(
      store: store,
      child: MaterialApp(
        title: 'homeCRM',
        theme: getApplicationTheme(),
        // Светлая тема
        darkTheme: getDarkApplicationTheme(),
        // Темная тема
        themeMode: ThemeMode.system,
        // По умолчанию используем систему устройства
        initialRoute: store.state.isLoggedIn
            ? RoutersApp.home
            : RoutersApp.login,
        routes: RoutersApp.routes,
      ),
    );
    return storeProvider;
  }
}
