import 'package:flutter/cupertino.dart';
import 'package:home_crm_front/domain/sub/authentication/authentication_middleware.dart';
import 'package:home_crm_front/domain/support/redux/state/app_state.dart';
import 'package:redux/redux.dart';

List<Middleware<AppState>> createMiddleware(BuildContext context) {
  return [authenticationMiddleware(context)];
}
