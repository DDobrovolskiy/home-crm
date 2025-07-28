import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/support/token_service.dart';

Future<AppState> initAppState() async {
  final String? authToken = await TokenService().getToken(
    TokenService.authToken,
  );
  debugPrint(authToken);
  final appState = AppState(authToken: authToken);
  if (authToken != null) {
    debugPrint('do http');
  }
  return appState;
class AppState {
  final String? authToken;

  const AppState({
    required this.authToken,
  });

  bool isLogged() {
    return authToken != null;
  }
}
