import 'package:dio/dio.dart';
import 'package:flutter_redux_navigation/flutter_redux_navigation.dart';
import 'package:home_crm_front/domain/sub/authentication/action/login_action.dart';
import 'package:home_crm_front/domain/sub/authentication/action/login_success_action.dart';
import 'package:home_crm_front/domain/sub/authentication/action/logout_action.dart';
import 'package:home_crm_front/domain/sub/authentication/action/logout_all_action.dart';
import 'package:home_crm_front/domain/sub/authentication/dto/logout_all_dto.dart';
import 'package:home_crm_front/domain/sub/authentication/dto/simple_auth_dto.dart';
import 'package:home_crm_front/domain/sub/authentication/dto/simple_login_dto.dart';
import 'package:home_crm_front/domain/support/port/port.dart';
import 'package:home_crm_front/domain/support/token_service.dart';
import 'package:redux/redux.dart';

import '../../../support/redux/state/app_state.dart';
import '../../../support/router/roters.dart';
import '../action/registration_action.dart';
import '../action/registration_success_action.dart';
import '../dto/auth_response_dto.dart';

class AuthMiddleware implements MiddlewareClass<AppState> {
  @override
  call(Store<AppState> store, action, NextDispatcher next) async {
    if (action is RegistrationAction) {
      try {
        store.state.authState.registrationState.messageError = null;
        await Dio()
            .post(
              Port.path("auth/registration"),
              data: SimpleAuthDto(
                phone: action.phone,
                password: action.password,
              ).toJson(),
              options: Options(contentType: 'application/json'),
            )
            .then((response) {
              if (response.statusCode == 200) {
                var auth = AuthResponseDto.fromJson(response.data);
                if (auth.status == 0 && auth.data != null) {
                  TokenService()
                      .saveToken(TokenService.authToken, auth.data!)
                      .then((value) {
                        next(RegistartionSuccesAction(token: auth.data));
                        store.dispatch(
                          NavigateToAction.replace(RoutersApp.home),
                        );
                      });
                } else {
                  store.state.authState.registrationState.messageError = auth
                      .fullErrorMessage();
                }
              } else {
                store.state.authState.registrationState.messageError =
                    'Ошибка сервиса регистрации, повторите попытку позже';
              }
            });
      } finally {
        store.state.authState.registrationState.load = false;
      }
    } else if (action is LoginAction) {
      try {
        store.state.authState.loginState.messageError = null;
        await Dio()
            .post(
              Port.path("auth/login"),
              data: SimpleLoginDto(
                phone: action.phone,
                password: action.password,
              ).toJson(),
              options: Options(contentType: 'application/json'),
            )
            .then((response) {
              if (response.statusCode == 200) {
                var auth = AuthResponseDto.fromJson(response.data);
                if (auth.status == 0 && auth.data != null) {
                  TokenService()
                      .saveToken(TokenService.authToken, auth.data!)
                      .then((value) {
                        next(LoginSuccessAction(token: auth.data));
                        store.dispatch(
                          NavigateToAction.replace(RoutersApp.home),
                        );
                      });
                } else {
                  store.state.authState.loginState.messageError = auth
                      .fullErrorMessage();
                }
              } else {
                store.state.authState.loginState.messageError =
                    'Ошибка сервиса регистрации, повторите попытку позже';
              }
            });
      } finally {
        store.state.authState.loginState.load = false;
      }
    } else if (action is LogoutAction) {
      TokenService().clearToken(TokenService.authToken).then((value) {
        store.state.authToken = null;
        store.dispatch(NavigateToAction.replace(RoutersApp.login));
      });
    } else if (action is LogoutAllAction) {
      Port.post("auth/logout", LogoutAllDto().toJson()).then((response) {
        TokenService().clearToken(TokenService.authToken).then((value) {
          store.state.authToken = null;
          store.dispatch(NavigateToAction.replace(RoutersApp.login));
        });
      });
    }
  }
}
