import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_crm_front/domain/support/port/response_dto.dart';
import 'package:redux/redux.dart';

import '../../sub/authentication/action/logout_action.dart';
import '../notifications/actions/simple_notification.dart';
import '../redux/state/app_state.dart';
import '../token_service.dart';

class Port {
  static String path(String path) {
    var baseUrl = dotenv.env['BASE_URL'];
    return "$baseUrl$path";
  }

  static Future<Response> getWithoutHandler(String path) async {
    return await TokenService().getToken(TokenService.authToken).then((
      token,
    ) async {
      return await Dio().get(
        Port.path(path),
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': token},
        ),
      );
    });
  }

  static Future<Response> postWithoutHandler(
    String path,
    Map<String, dynamic> body,
  ) async {
    return await TokenService().getToken(TokenService.authToken).then((
      token,
    ) async {
      return await Dio().post(
        Port.path(path),
        data: body,
        options: Options(
          contentType: 'application/json',
          headers: {'Authorization': token},
        ),
      );
    });
  }

  static void get<T, R>(
    String path,
    Store<AppState> store,
    T Function(Object? json) fromJsonT,
    FutureOr<R> Function(T? value) action, {
    Function? onError,
  }) async {
    await TokenService().getToken(TokenService.authToken).then((
      authToken,
    ) async {
      return await TokenService().getToken(TokenService.organizationToken).then(
        (orgToken) async {
          Map<String, dynamic>? headers = getHeaders(authToken, orgToken);
          return await Dio()
              .get(
                Port.path(path),
                options: Options(
                  contentType: 'application/json',
                  headers: headers,
                ),
              )
              .then(handler(store, fromJsonT))
              .then(action);
        },
      );
    });
  }

  static void post<T, R>(
    String path,
    Map<String, dynamic> body,
    Store<AppState> store,
    T Function(Object? json) fromJsonT,
    FutureOr<R> Function(T? value) action, {
    Function? onError,
  }) async {
    await TokenService().getToken(TokenService.authToken).then((
      authToken,
    ) async {
      return await TokenService().getToken(TokenService.organizationToken).then(
        (orgToken) async {
          Map<String, dynamic>? headers = getHeaders(authToken, orgToken);
          return await Dio()
              .post(
                Port.path(path),
                data: body,
                options: Options(
                  contentType: 'application/json',
                  headers: headers,
                ),
              )
              .then(handler(store, fromJsonT))
              .then(action);
        },
      );
    });
  }

  static void delete<T, R>(
    String path,
    Map<String, dynamic> body,
    Store<AppState> store,
    T Function(Object? json) fromJsonT,
    FutureOr<R> Function(T? value) action, {
    Function? onError,
  }) async {
    await TokenService().getToken(TokenService.authToken).then((
      authToken,
    ) async {
      return await TokenService().getToken(TokenService.organizationToken).then(
        (orgToken) async {
          Map<String, dynamic>? headers = getHeaders(authToken, orgToken);
          return await Dio()
              .delete(
                Port.path(path),
                data: body,
                options: Options(
                  contentType: 'application/json',
                  headers: headers,
                ),
              )
              .then(handler(store, fromJsonT))
              .then(action);
        },
      );
    });
  }

  static void put<T, R>(
    String path,
    Map<String, dynamic> body,
    Store<AppState> store,
    T Function(Object? json) fromJsonT,
    FutureOr<R> Function(T? value) action, {
    Function? onError,
  }) async {
    await TokenService().getToken(TokenService.authToken).then((
      authToken,
    ) async {
      return await TokenService().getToken(TokenService.organizationToken).then(
        (orgToken) async {
          Map<String, dynamic>? headers = getHeaders(authToken, orgToken);
          return await Dio()
              .put(
                Port.path(path),
                data: body,
                options: Options(
                  contentType: 'application/json',
                  headers: headers,
                ),
              )
              .then(handler(store, fromJsonT))
              .then(action);
        },
      );
    });
  }

  static Map<String, dynamic>? getHeaders(String? authToken, String? orgToken) {
    Map<String, dynamic>? headers = {};
    if (authToken != null) {
      headers.putIfAbsent('Authorization', () => authToken);
    }
    if (orgToken != null) {
      headers.putIfAbsent('Organization', () => orgToken);
    }
    return headers;
  }

  static FutureOr<T?> Function(Response value) handler<T>(
    Store<AppState> store,
    T Function(Object? json) fromJsonT,
  ) {
    return (response) {
      if (response.statusCode == 401) {
        store.dispatch(LogoutAction());
      } else if (response.statusCode == 500) {
        debugPrint('Внутреняя ошибка сервиса!');
        store.dispatch(
          SimpleNotifications(message: 'Внутреняя ошибка сервиса!'),
        );
      } else {
        return ResponseDTO<T>.fromJson(response.data, fromJsonT).data;
      }
    };
  }
}
