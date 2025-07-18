import 'dart:developer';
import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:home_crm_front/router/router.dart';
import 'package:home_crm_front/theme/theme.dart';

import 'cookie/cookie_handler.dart';

class CrmApp extends StatelessWidget {
  const CrmApp({super.key});

  @override
  Widget build(BuildContext context) {
    CookieHandler().getValue("key")
    .then((value) {
      if(value == null) {
        CookieHandler().saveValue("key", DateTime.timestamp().toIso8601String());
      }
    });
    return MaterialApp(
      title: 'Flutter Demo',
      theme: defaultTheme,
      onGenerateRoute: (settings) => generateRoute(settings),
      routes: routes,
    );
  }

}