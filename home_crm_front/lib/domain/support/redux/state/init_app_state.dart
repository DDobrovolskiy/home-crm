import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/support/token_service.dart';

import 'app_state.dart';

Future<AppState> initAppState() async {
  final String? authToken = await TokenService().getToken(
    TokenService.authToken,
  );
  debugPrint(authToken);
  final appState = AppState(authToken);
  if (authToken != null) {
    //
    debugPrint('do http');
  }
  return appState;
}
