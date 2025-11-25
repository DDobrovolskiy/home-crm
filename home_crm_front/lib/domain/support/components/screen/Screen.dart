import 'package:flutter/cupertino.dart';

class Screen {
  static bool isWeb(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > 600;
  }
}
