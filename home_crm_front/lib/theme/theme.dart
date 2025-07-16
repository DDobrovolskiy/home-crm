import 'dart:io';

import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final defaultTheme = ThemeData(
  // primarySwatch: Colors.amber,
  colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
  scaffoldBackgroundColor: Color.fromRGBO(253, 253, 253, 255),
  dividerColor: Colors.white30,
  listTileTheme: ListTileThemeData(iconColor: Colors.black45),
  appBarTheme: AppBarTheme(
    backgroundColor: Color.fromRGBO(253, 253, 253, 255),
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 25),
  ),
  textTheme: TextTheme(
    bodyMedium: TextStyle(
      color: Colors.black.withAlpha(180),
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    bodySmall: TextStyle(
      color: Colors.black.withAlpha(125),
      fontWeight: FontWeight.w700,
      fontSize: 14,
    ),
  ),
);