import 'package:flutter/material.dart';
import 'package:home_crm_front/home_crm_app.dart';

import 'domain/support/token_service.dart';

Future<void> main() async {
  debugPrint('Creating main at timestamp: ${DateTime.now()}');
  String? authToken = await TokenService().getToken(TokenService.authToken);
  runApp(HomeCrmApp(authToken: authToken));
}
