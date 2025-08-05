import 'package:dio/dio.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:home_crm_front/domain/support/port/port.dart';
import 'package:home_crm_front/domain/support/token_service.dart';
import 'package:redux/redux.dart';

import '../../../support/redux/state/app_state.dart';
import '../../../support/router/roters.dart';
import '../action/registration_action.dart';
import '../action/registration_success_action.dart';
import '../dto/auth_response_dto.dart';

class RegistrationMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is RegistrationAction) {
      try {
        await Dio().post(Port.getPath("auth/registration"),
            data: action.toMap(),
            options: Options(contentType: 'application/json'))
            .then((response) {
          if (response.statusCode == 200) {
            var auth = AuthResponseDto.fromJson(response.data);
            if (auth.status == 0 && auth.data != null) {
              TokenService().saveToken(TokenService.authToken, auth.data!);
              next(RegistartionSuccesAction(token: auth.data));
              store.dispatch(NavigateToAction.replace(RoutersApp.home));
            } else {
              store.state.registration.messageError = auth.errorData?.message;
            }
          } else {
            store.state.registration.messageError =
            'Ошибка сервиса регистрации, повторите попытку позже';
          }
        });
      } finally {
        store.state.registration.load = false;
      }
    }
  }

}
