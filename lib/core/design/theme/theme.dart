// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nasa_daily_app/core/design/theme/palette.dart';

class DefaultTheme {
  static void init() {
    GoogleFonts.config.allowRuntimeFetching = false;
  }

  static ThemeData getTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        primarySwatch: Palette.materialPrimary,
        primaryColor: Palette.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Palette.secondary,
          primary: Palette.primary,
          brightness: Brightness.light,
          onPrimary: Palette.onPrimaryColor,
          onSecondary: Palette.onSecondaryColor,
        ),
        scaffoldBackgroundColor: Palette.backgroundColor,
        iconTheme: DarkTheme.iconTheme(),
        dialogBackgroundColor: Palette.primary,
        floatingActionButtonTheme: DarkTheme.floatingActionButtonTheme(),
        textTheme: DarkTheme.textTheme(),
        outlinedButtonTheme: DarkTheme.outlinedButtonTheme(),
        elevatedButtonTheme: DarkTheme.elevatedButtonTheme(),
        inputDecorationTheme: DarkTheme.inputDecoration(),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: DarkTheme.inputDecoration(),
          textStyle: TextStyle(
            color: Palette.primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.barlow().fontFamily,
          ),
        ),
        textButtonTheme: DarkTheme.textButtonTheme(),
        brightness: Brightness.light,
        textSelectionTheme: DarkTheme.textSelectionTheme(),
        appBarTheme: appBarDecoration(),
        progressIndicatorTheme: progressIndicatorTheme(),
        cardColor: Palette.secondary,
        cardTheme: const CardTheme(color: Colors.white, elevation: 2),
        dividerColor: Palette.dividerColor,
        canvasColor: Colors.white,
      );

  static appBarDecoration() {
    return AppBarTheme(
      color: Palette.primary,
      iconTheme: IconThemeData(
        color: Palette.secondary,
      ),
      titleTextStyle: TextStyle(
        fontFamily: GoogleFonts.barlow().fontFamily,
        color: Palette.onPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: false,
      elevation: 0,
    );
  }

  static inputDecoration() {
    return InputDecorationTheme(
      fillColor: Palette.inputBackground,
      focusColor: Palette.secondary,
      hoverColor: Palette.secondary,
      filled: false,
      labelStyle: inputDecorationTextTheme(
        color: Palette.primaryTextColor,
        bold: false,
        size: 14,
      ),
      errorMaxLines: 2,
      suffixIconColor: Palette.primaryTextColor,
      prefixIconColor: Palette.primaryTextColor,
      hintStyle: inputDecorationTextTheme(size: 14, color: Palette.primaryTextColor),
      errorStyle: inputDecorationTextTheme(size: 12, color: Palette.error),
      errorBorder: inputDecorationBorderStyle(color: Palette.error),
      focusedErrorBorder: inputDecorationBorderStyle(color: Palette.error),
      contentPadding: const EdgeInsets.all(8),
      border: inputDecorationBorderStyle(color: Palette.primaryTextColor),
      enabledBorder: inputDecorationBorderStyle(color: Palette.primaryTextColor),
      focusedBorder: inputDecorationBorderStyle(color: Palette.primary),
    );
  }

  static inputDecorationBorderStyle({@required color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }

  static inputDecorationTextTheme({color, double size = 14, bool bold = false}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.w400,
    );
  }

  static TextTheme textTheme() => GoogleFonts.barlowTextTheme(
        const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.primaryTextColor,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.primaryTextColor,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Palette.primaryTextColor,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Palette.primaryTextColor,
            decorationThickness: 0,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.primaryTextColor,
            decorationThickness: 0,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Palette.primaryTextColor,
            decorationThickness: 0,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Palette.primaryTextColor,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Palette.primaryTextColor,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Palette.primaryTextColor,
          ),
        ),
      );

  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Palette.primary,
        foregroundColor: Palette.primary,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Palette.onPrimaryColor,
        ),
        minimumSize: const Size(80, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  static TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(
      style: OutlinedButton.styleFrom(
        enableFeedback: true,
        foregroundColor: Palette.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Palette.primary,
        backgroundColor: Colors.white,
        minimumSize: const Size(80, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        side: const BorderSide(color: Colors.white, width: 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  static TextSelectionThemeData textSelectionTheme() {
    return const TextSelectionThemeData(
        cursorColor: Palette.primary, selectionColor: Palette.secondary, selectionHandleColor: Palette.primary);
  }

  static floatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: Palette.primary,
      iconSize: 32,
    );
  }

  static iconTheme() {
    return const IconThemeData(color: Palette.primaryTextColor);
  }

  static progressIndicatorTheme() {
    return const ProgressIndicatorThemeData(
      color: Palette.primary,
    );
  }
}

class DarkTheme {
  static void init() {
    GoogleFonts.config.allowRuntimeFetching = false;
  }

  static ThemeData getTheme(BuildContext context) => ThemeData(
        useMaterial3: true,
        primarySwatch: Palette.materialPrimary,
        primaryColor: Palette.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: Palette.secondary,
          primary: Palette.primary,
        ),
        scaffoldBackgroundColor: Palette.backgroundColor,
        iconTheme: DarkTheme.iconTheme(),
        dialogBackgroundColor: Palette.primary,
        floatingActionButtonTheme: DarkTheme.floatingActionButtonTheme(),
        textTheme: DarkTheme.textTheme(),
        outlinedButtonTheme: DarkTheme.outlinedButtonTheme(),
        elevatedButtonTheme: DarkTheme.elevatedButtonTheme(),
        inputDecorationTheme: DarkTheme.inputDecoration(),
        dropdownMenuTheme: DropdownMenuThemeData(
          inputDecorationTheme: DarkTheme.inputDecoration(),
          textStyle: TextStyle(
            color: Palette.primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: GoogleFonts.barlow().fontFamily,
          ),
        ),
        textButtonTheme: DarkTheme.textButtonTheme(),
        brightness: Brightness.light,
        textSelectionTheme: DarkTheme.textSelectionTheme(),
        appBarTheme: appBarDecoration(),
        progressIndicatorTheme: progressIndicatorTheme(),
        cardColor: Palette.secondary,
        cardTheme: const CardTheme(color: Colors.white, elevation: 2),
        dividerColor: Palette.dividerColor,
        canvasColor: Colors.white,
      );

  static appBarDecoration() {
    return AppBarTheme(
      color: Palette.primary,
      iconTheme: IconThemeData(
        color: Palette.secondary,
      ),
      titleTextStyle: TextStyle(
        fontFamily: GoogleFonts.barlow().fontFamily,
        color: Palette.onPrimaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      centerTitle: false,
      elevation: 0,
    );
  }

  static inputDecoration() {
    return InputDecorationTheme(
      fillColor: Palette.inputBackground,
      focusColor: Palette.secondary,
      hoverColor: Palette.secondary,
      filled: false,
      labelStyle: inputDecorationTextTheme(
        color: Palette.primaryTextColor,
        bold: false,
        size: 14,
      ),
      errorMaxLines: 2,
      suffixIconColor: Palette.primaryTextColor,
      prefixIconColor: Palette.primaryTextColor,
      hintStyle: inputDecorationTextTheme(size: 14, color: Palette.primaryTextColor),
      errorStyle: inputDecorationTextTheme(size: 12, color: Palette.error),
      errorBorder: inputDecorationBorderStyle(color: Palette.error),
      focusedErrorBorder: inputDecorationBorderStyle(color: Palette.error),
      contentPadding: const EdgeInsets.all(8),
      border: inputDecorationBorderStyle(color: Palette.primaryTextColor),
      enabledBorder: inputDecorationBorderStyle(color: Palette.primaryTextColor),
      focusedBorder: inputDecorationBorderStyle(color: Palette.primary),
    );
  }

  static inputDecorationBorderStyle({@required color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(8)),
    );
  }

  static inputDecorationTextTheme({color, double size = 14, bool bold = false}) {
    return TextStyle(
      color: color,
      fontSize: size,
      fontWeight: bold ? FontWeight.bold : FontWeight.w400,
    );
  }

  static TextTheme textTheme() => GoogleFonts.barlowTextTheme(
        const TextTheme(
          titleLarge: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Palette.primaryTextColor,
          ),
          titleMedium: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Palette.primaryTextColor,
          ),
          titleSmall: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Palette.primaryTextColor,
          ),
          bodySmall: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Palette.primaryTextColor,
            decorationThickness: 0,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Palette.primaryTextColor,
            decorationThickness: 0,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Palette.primaryTextColor,
            decorationThickness: 0,
          ),
          labelLarge: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: Palette.primaryTextColor,
          ),
          labelMedium: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            color: Palette.primaryTextColor,
          ),
          labelSmall: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: Palette.primaryTextColor,
          ),
        ),
      );

  static ElevatedButtonThemeData elevatedButtonTheme() {
    return ElevatedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: Palette.primary,
        foregroundColor: Palette.primary,
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Palette.onPrimaryColor,
        ),
        minimumSize: const Size(80, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  static TextButtonThemeData textButtonTheme() {
    return TextButtonThemeData(
      style: OutlinedButton.styleFrom(
        enableFeedback: true,
        foregroundColor: Palette.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData outlinedButtonTheme() {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: Palette.primary,
        backgroundColor: Colors.white,
        minimumSize: const Size(80, 48),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        side: const BorderSide(color: Colors.white, width: 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
      ),
    );
  }

  static TextSelectionThemeData textSelectionTheme() {
    return const TextSelectionThemeData(
        cursorColor: Palette.primary, selectionColor: Palette.secondary, selectionHandleColor: Palette.primary);
  }

  static floatingActionButtonTheme() {
    return const FloatingActionButtonThemeData(
      backgroundColor: Palette.primary,
      iconSize: 32,
    );
  }

  static iconTheme() {
    return const IconThemeData(color: Palette.primaryTextColor);
  }

  static progressIndicatorTheme() {
    return const ProgressIndicatorThemeData(
      color: Palette.primary,
    );
  }
}
