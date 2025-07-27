import 'dart:developer';

import 'package:flutter/cupertino.dart';

bool isMobile(BuildContext context) {
  debugPrint('Creating ScreenInfo at timestamp: ${DateTime.now()}');
  final screenSize = MediaQuery.of(context).size;
  bool isMobile = screenSize.shortestSide <= 600;
  log('screenSize: $screenSize');
  log('isSmallScreen: $isMobile');
  return isMobile;
}