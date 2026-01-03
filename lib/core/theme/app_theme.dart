import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../consts/color_manager.dart';
import '../consts/font_manager.dart';

class AppTheme {
  // Light Theme
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.primary,
        primary: ColorManager.primary,
        secondary: ColorManager.primaryLight,
        error: ColorManager.error,
        surface: ColorManager.white,
      ),
      scaffoldBackgroundColor: ColorManager.backgroundColor,
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.light().textTheme.apply(
          bodyColor: ColorManager.textPrimary,
          displayColor: ColorManager.textPrimary,
        ),
      ),
      fontFamily: FontConstants.fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorManager.textPrimary),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ColorManager.textPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: ColorManager.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorManager.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dividerColor: ColorManager.grey4,
    );
  }

  // Dark Theme
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorManager.darkPrimary,
        brightness: Brightness.dark,
        primary: ColorManager.darkPrimary,
        secondary: ColorManager.darkPrimaryLight,
        error: ColorManager.darkError,
        surface: ColorManager.darkCardBackground,
      ),
      scaffoldBackgroundColor: ColorManager.darkBackground,
      textTheme: GoogleFonts.poppinsTextTheme(
        ThemeData.dark().textTheme.apply(
          bodyColor: ColorManager.darkTextPrimary,
          displayColor: ColorManager.darkTextPrimary,
        ),
      ),
      fontFamily: FontConstants.fontFamily,
      appBarTheme: AppBarTheme(
        backgroundColor: ColorManager.darkCardBackground,
        elevation: 0,
        iconTheme: const IconThemeData(color: ColorManager.darkTextPrimary),
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: ColorManager.darkTextPrimary,
        ),
      ),
      cardTheme: CardThemeData(
        color: ColorManager.darkCardBackground,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: ColorManager.darkCardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: ColorManager.darkCardBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
      ),
      dividerColor: ColorManager.darkGrey4,
    );
  }
}
