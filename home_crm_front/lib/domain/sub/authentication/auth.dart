import 'package:flutter/material.dart';
import 'package:redux/redux.dart';

import '../../support/redux/state/app_state.dart';
import '../../support/router/roters.dart';

Future<void> checkAuthAndNavigate(
  BuildContext context,
  Store<AppState> store,
) async {
  // Получаем токен из хранилища
  final token = store.state.authToken;
  if (token == null) {
    // Токен отсутствует, переходим на страницу регистрации
    Navigator.pushReplacementNamed(context, RoutersApp.registration);
  } else {
    // Проверяем валидность токена на сервере
    final isValid = await validateToken(token);

    if (isValid) {
      // Токен валиден, переходим на домашнюю страницу
      Navigator.pushReplacementNamed(context, RoutersApp.home);
    } else {
      // Токен невалиден, очищаем его и переходим на регистрацию
      // store.dispatch(AuthActions.clearToken());
      Navigator.pushReplacementNamed(context, RoutersApp.registration);
    }
  }
}

// Пример функции проверки токена на сервере
Future<bool> validateToken(String token) async {
  // Здесь должна быть реальная логика проверки токена на сервере
  // Возвращаем true, если токен валиден, false - если нет
  return true; // Replace with actual implementation
}
