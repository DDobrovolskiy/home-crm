import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Определим наши фирменные цвета
extension CustomColors on BuildContext {
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
}

// Основная тема приложения
ThemeData getApplicationTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primaryColor: CustomColors.primaryColor,
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
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,) {
          return CustomColors.accentColor2; // голубой цвет для активных кнопок
        }),
        foregroundColor: WidgetStateProperty.resolveWith((
            Set<WidgetState> states,) {
          return CustomColors.whiteColor; // голубой цвет для активных кнопок
        }),
      ),
    ),
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
