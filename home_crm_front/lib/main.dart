import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:home_crm_front/home_crm_app.dart';

import 'domain/support/redux/state/app_state.dart';
import 'domain/support/redux/state/init_app_state.dart';

Future<void> main() async {
  debugPrint('Creating main at timestamp: ${DateTime.now()}');
  await dotenv.load(fileName: ".env");
  AppState appState = await initAppState();
  runApp(HomeCrmApp(appState: appState));
}
