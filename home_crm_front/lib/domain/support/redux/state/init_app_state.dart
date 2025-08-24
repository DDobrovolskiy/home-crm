import 'package:home_crm_front/domain/support/port/port.dart';
import 'package:home_crm_front/domain/support/token_service.dart';

import 'app_state.dart';

Future<AppState> initAppState() async {
  return await TokenService().getToken(TokenService.authToken).then((
    token,
  ) async {
    if (token != null) {
      return await Port.getWithoutHandler("auth/check").then((response) {
        if (response.statusCode == 200 && response.data as bool) {
          print("check token true");
          return AppState(token);
        }
        print("check token false");
        return AppState(null);
      });
    } else {
      print("token null");
      return AppState(null);
    }
  });
}
