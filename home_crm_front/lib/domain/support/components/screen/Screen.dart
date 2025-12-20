import 'package:flutter/cupertino.dart';

class Screen {
  static bool isWeb(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > getNavBarWidth() + getMaxWidth();
  }

  static bool isSidePanel(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth > getNavBarWidth() + getMaxWidth() + getMaxWidth();
  }

  static bool isHeight(BuildContext context, int height) {
    final screenWidth = MediaQuery.of(context).size.height;
    return screenWidth > height;
  }

  static double getMaxWidth() {
    return 700;
  }

  static double getNavBarWidth() {
    return 270;
  }

  static double getWidthWithMaxWidth(BuildContext context) {
    if (MediaQuery.of(context).size.width > getMaxWidth()) {
      return getMaxWidth();
    }
    return MediaQuery.of(context).size.width;
  }
}
