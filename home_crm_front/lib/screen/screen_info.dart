import 'dart:developer';

import 'package:flutter/cupertino.dart';

class ScreenInfo with ChangeNotifier {
  late final bool isMobile;

  ScreenInfo(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    isMobile = screenSize.shortestSide <= 600;
    log('screenSize: $screenSize');
    log('isSmallScreen: $isMobile');
  }
}