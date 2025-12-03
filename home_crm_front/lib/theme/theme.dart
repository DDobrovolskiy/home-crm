import 'dart:core';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Определим наши фирменные цвета
extension CustomColors on BuildContext {

  static bool isDarkMode(BuildContext context) {
    return Theme
        .of(context)
        .brightness == Brightness.dark;
  }


  static const Color primary = Color(0xFF6F61EF);

  static Color getPrimary(BuildContext context) {
    return primary;
  }

  static const Color secondary = Color(0xFF39D2C0);

  static Color getSecondary(BuildContext context) {
    return secondary;
  }

  static const Color tertiary = Color(0xFFEE8B60);

  static Color getTertiary(BuildContext context) {
    return tertiary;
  }

  static const Color gold = Color(0xFFEECD60);

  static Color getGold(BuildContext context) {
    return gold;
  }

  static const Color alternate = Color(0xFFE5E7EB);
  static const Color alternateDark = Color(0xFF313442);

  static Color getAlternate(BuildContext context) {
    return isDarkMode(context) ? alternateDark : alternate;
  }

  static const Color primaryText = Color(0xFF15161E);
  static const Color primaryTextDark = Color(0xFFFFFFFF);

  static Color getPrimaryText(BuildContext context) {
    return isDarkMode(context) ? primaryTextDark : primaryText;
  }

  static const Color secondaryText = Color(0xFF606A85);
  static const Color secondaryTextDark = Color(0xFFA9ADC6);

  static Color getSecondaryText(BuildContext context) {
    return isDarkMode(context) ? secondaryTextDark : secondaryText;
  }

  static const Color primaryBackground = Color(0xFFF1F4F8);
  static const Color primaryBackgroundDark = Color(0xFF15161E);

  static Color getPrimaryBackground(BuildContext context) {
    return isDarkMode(context) ? primaryBackgroundDark : primaryBackground;
  }

  static const Color secondaryBackground = Color(0xFFFFFFFF);
  static const Color secondaryBackgroundDark = Color(0xFF1B1D27);

  static Color getSecondaryBackground(BuildContext context) {
    return isDarkMode(context) ? secondaryBackgroundDark : secondaryBackground;
  }

  static const Color accent1 = Color(0x4D9489F5);

  static Color getAccent1(BuildContext context) {
    return accent1;
  }

  static const Color accent2 = Color(0x4C39d2c0);

  static Color getAccent2(BuildContext context) {
    return accent2;
  }

  static const Color accent3 = Color(0x4DEE8B60);

  static Color getAccent3(BuildContext context) {
    return accent3;
  }

  static const Color accent4 = Color(0x99FFFFFF);
  static const Color accent4Dark = Color(0x991D2428);

  static Color getAccent4(BuildContext context) {
    return isDarkMode(context) ? accent4Dark : accent4;
  }


  static const Color success = Color(0xFF048178);

  static Color getSuccess(BuildContext context) {
    return success;
  }

  static const Color error = Color(0xffff5963);

  static Color getError(BuildContext context) {
    return error;
  }

  static const Color warning = Color(0xfffcdc0c);

  static Color getWarning(BuildContext context) {
    return warning;
  }

  static const Color info = Color(0xFFFFFFFF);

  static Color getInfo(BuildContext context) {
    return info;
  }

  static const Color primaryBtnText = Color(0xFFFFFFFF);

  static Color getPrimaryBtnText(BuildContext context) {
    return primaryBtnText;
  }

  static const Color testingTextTariff = Color(0xFF15161E);

  static Color getTextTestingTariff(BuildContext context) {
    return testingTextTariff;
  }

  static const Color testingTariff = Color(0xFF15161E);

  static Color getTestingTariff(BuildContext context) {
    return testingTariff;
  }

  static const Color lineColor = Color(0xffdbe2e7);
  static const Color lineColorDark = Color(0xff22282f);

  static Color getLineColor(BuildContext context) {
    return isDarkMode(context) ? lineColorDark : lineColor;
  }

  static const Color overlay = Color(0x991d2428);

  static Color getOverlay(BuildContext context) {
    return overlay;
  }

  static const Color overlay0 = Color(0xFFFFFF);

  static Color getOverlay0(BuildContext context) {
    return overlay0;
  }

  static TextStyle getOutfitPrimary(double size, FontWeight fontWeight,
      BuildContext context, Color? color) {
    return GoogleFonts.outfit(
      fontSize: size,
      fontWeight: fontWeight,
      color: color ?? getPrimaryText(context),
    );
  }

  static TextStyle getOutfitSecondary(double size, FontWeight fontWeight,
      BuildContext context, Color? color) {
    return GoogleFonts.outfit(
      fontSize: size,
      fontWeight: fontWeight,
      color: color ?? getSecondaryText(context),
    );
  }

  static TextStyle getPlusJakartaSansPrimary(double size, FontWeight fontWeight,
      BuildContext context, Color? color) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: fontWeight,
      color: color ?? getPrimaryText(context),
    );
  }

  static TextStyle getPlusJakartaSansInfo(double size, FontWeight fontWeight,
      BuildContext context, Color? color) {
    return GoogleFonts.plusJakartaSans(
      fontSize: size,
      fontWeight: fontWeight,
      color: color ?? getInfo(context),
    );
  }

  static TextStyle getDisplayLarge(BuildContext context, Color? color) {
    return getOutfitPrimary(57, FontWeight.normal, context, color);
  }

  static TextStyle getDisplayMedium(BuildContext context, Color? color) {
    return getOutfitPrimary(45, FontWeight.normal, context, color);
  }

  static TextStyle getDisplaySmall(BuildContext context, Color? color) {
    return getOutfitPrimary(36, FontWeight.w600, context, color);
  }

  static TextStyle getHeadLineLarge(BuildContext context, Color? color) {
    return getOutfitPrimary(32, FontWeight.normal, context, color);
  }

  static TextStyle getHeadLineMedium(BuildContext context, Color? color) {
    return getOutfitPrimary(24, FontWeight.w500, context, color);
  }

  static TextStyle getHeadLineSmall(BuildContext context, Color? color) {
    return getOutfitPrimary(22, FontWeight.bold, context, color);
  }

  static TextStyle getTitleLarge(BuildContext context, Color? color) {
    return getOutfitPrimary(22, FontWeight.w500, context, color);
  }

  static TextStyle getTitleMedium(BuildContext context, Color? color) {
    return getPlusJakartaSansInfo(18, FontWeight.w500, context, color);
  }

  static TextStyle getTitleSmall(BuildContext context, Color? color) {
    return getPlusJakartaSansInfo(16, FontWeight.w500, context, color);
  }

  static TextStyle getLabelLarge(BuildContext context, Color? color) {
    return getOutfitSecondary(16, FontWeight.w500, context, color);
  }

  static TextStyle getLabelMedium(BuildContext context, Color? color) {
    return getOutfitSecondary(14, FontWeight.w500, context, color);
  }

  static TextStyle getLabelSmall(BuildContext context, Color? color) {
    return getOutfitSecondary(12, FontWeight.w500, context, color);
  }

  static TextStyle getBodyLarge(BuildContext context, Color? color) {
    return getPlusJakartaSansPrimary(16, FontWeight.w500, context, color);
  }

  static TextStyle getBodyMedium(BuildContext context, Color? color) {
    return getPlusJakartaSansPrimary(14, FontWeight.w500, context, color);
  }

  static TextStyle getBodySmall(BuildContext context, Color? color) {
    return getPlusJakartaSansPrimary(12, FontWeight.w500, context, color);
  }

  //light
  static const Color accentAlterColor = Color(0xFFEE2F53);
  static const Color accentColor = Color(0xFF006AB3);
  static const Color accentColor1 = Color(0xFF3960BE);
  static const Color accentColor2 = Color(0xFF325ECE);

  static const Color gray = Color(0xFFF4F4F4);

  static const Color blackColor = Color(0xFF0B1F33);
  static const Color primaryColor = Color(0xFFEDF2FE);
  static const Color whiteColor = Color(0xFFFFFFFF);

  static const Color backgroundDark = Color(0xFF121212); // Темный фон

  static InputDecoration getTextFormInputDecoration(String label,
      BuildContext context) {
    return InputDecoration(
      labelText: label,
      labelStyle: CustomColors.getLabelMedium(context, null),
      hintStyle: CustomColors.getBodySmall(context, null),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.getPrimaryBackground(context),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(0x00000000),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.getError(context),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.getError(context),
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: CustomColors.getSecondaryBackground(context),
      contentPadding: EdgeInsetsDirectional.fromSTEB(20, 24, 0, 24),
    );
  }
}

// Основная тема приложения
ThemeData getApplicationTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.primary,

    hintColor: CustomColors.accentColor,
    appBarTheme: AppBarTheme(
      backgroundColor: CustomColors.primaryColor,
      titleTextStyle: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: CustomColors.blackColor,
      ),
    ),
    cardTheme: CardThemeData(color: CustomColors.gray),
    buttonTheme: ButtonThemeData(buttonColor: CustomColors.accentColor),
    canvasColor: CustomColors.whiteColor,
    scaffoldBackgroundColor: CustomColors.whiteColor,
    cardColor: CustomColors.whiteColor,
    dividerColor: Colors.grey.shade300,
    iconTheme: IconThemeData(),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: CustomColors.accentColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(16.0),
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade400),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(CustomColors.whiteColor),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return CustomColors.primaryColor.withOpacity(0.1);
          }
          return CustomColors.primaryColor;
        }),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        // shape: WidgetStateProperty.all(
        //   RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        // ),
        minimumSize: WidgetStateProperty.all(Size(double.maxFinite, 56)),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.openSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: CustomColors.blackColor,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: CustomColors.blackColor,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: CustomColors.blackColor,
      ),
      labelLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: CustomColors.blackColor,
      ),
      labelMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: CustomColors.blackColor,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: CustomColors.blackColor,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: CustomColors.blackColor,
      ),
    ),
  );
}

// Темная тема приложения
ThemeData getDarkApplicationTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    primaryColor: CustomColors.primaryColor,
    hintColor: CustomColors.accentColor,
    canvasColor: CustomColors.backgroundDark,
    scaffoldBackgroundColor: CustomColors.backgroundDark,
    cardColor: Colors.grey.shade800,
    dividerColor: Colors.grey.shade700,
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: CustomColors.accentColor,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: EdgeInsets.all(16.0),
      border: OutlineInputBorder(),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: CustomColors.primaryColor),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey.shade600),
      ),
      filled: true,
      fillColor: Colors.grey.shade800,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(CustomColors.backgroundDark),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return CustomColors.primaryColor.withOpacity(0.1);
          }
          return CustomColors.primaryColor;
        }),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
        ),
        minimumSize: WidgetStateProperty.all(Size(double.maxFinite, 56)),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.openSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: CustomColors.whiteColor,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: CustomColors.whiteColor,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: CustomColors.whiteColor,
      ),
      labelLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: CustomColors.whiteColor,
      ),
      labelMedium: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: CustomColors.whiteColor,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: CustomColors.whiteColor,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: CustomColors.whiteColor,
      ),
    ),
  );
}
