import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Определим наши фирменные цвета
extension CustomColors on BuildContext {
  static const Color primaryColor = Color(0xFF3F51B5); // Основной синий
  static const Color accentColor = Color(0xFFFFAD00); // Акцентный желтый
  static const Color backgroundLight = Color(0xFFFFFFFF); // Светлый фон
  static const Color backgroundDark = Color(0xFF121212); // Темный фон
}

// Основная тема приложения
ThemeData getApplicationTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.primaryColor,
    hintColor: CustomColors.accentColor,
    canvasColor: CustomColors.backgroundLight,
    scaffoldBackgroundColor: CustomColors.backgroundLight,
    cardColor: CustomColors.backgroundLight,
    dividerColor: Colors.grey.shade300,
    textSelectionTheme: TextSelectionThemeData(selectionColor: CustomColors.accentColor),
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
        foregroundColor: WidgetStateProperty.all(CustomColors.backgroundLight),
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return CustomColors.primaryColor.withOpacity(0.1);
          }
          return CustomColors.primaryColor;
        }),
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        )),
        minimumSize: WidgetStateProperty.all(Size(double.maxFinite, 56)),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.openSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.black,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
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
    textSelectionTheme: TextSelectionThemeData(selectionColor: CustomColors.accentColor),
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
        shape: WidgetStateProperty.all(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
        )),
        minimumSize: WidgetStateProperty.all(Size(double.maxFinite, 56)),
      ),
    ),
    textTheme: TextTheme(
      headlineLarge: GoogleFonts.openSans(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headlineMedium: GoogleFonts.openSans(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineSmall: GoogleFonts.openSans(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      bodyLarge: GoogleFonts.openSans(
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
      bodySmall: GoogleFonts.openSans(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.white,
      ),
    ),
  );
}