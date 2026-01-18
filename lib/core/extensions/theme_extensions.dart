import 'package:flutter/material.dart';
import '../consts/color_manager.dart';

/// Extension to get theme-aware colors throughout the app
extension ThemeContext on BuildContext {
  /// Returns true if dark mode is active
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Theme-aware colors
  ThemeColors get colors => ThemeColors(this);
}

class ThemeColors {
  final BuildContext context;

  ThemeColors(this.context);

  bool get _isDark => context.isDarkMode;

  // Primary Colors
  Color get primary => _isDark ? ColorManager.darkPrimary : ColorManager.primary;
  Color get primaryDark => _isDark ? ColorManager.darkPrimaryDark : ColorManager.primaryDark;
  Color get primaryLight => _isDark ? ColorManager.darkPrimaryLight : ColorManager.primaryLight;

  // Background Colors
  Color get background => _isDark ? ColorManager.darkBackground : ColorManager.backgroundColor;
  Color get cardBackground => _isDark ? ColorManager.darkCardBackground : ColorManager.white;
  Color get surface => _isDark ? ColorManager.darkCardBackground : ColorManager.white;
  Color get surfaceVariant => _isDark ? ColorManager.darkSurfaceVariant : ColorManager.grey6;

  // Text Colors
  Color get textPrimary => _isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary;
  Color get textSecondary => _isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary;
  Color get textTertiary => _isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary;
  Color get textOnPrimary => _isDark ? ColorManager.darkTextOnPrimary : ColorManager.textOnPrimary;

  // Grey Scale
  Color get grey => _isDark ? ColorManager.darkGrey : ColorManager.grey;
  Color get grey1 => _isDark ? ColorManager.darkGrey1 : ColorManager.grey1;
  Color get grey2 => _isDark ? ColorManager.darkGrey2 : ColorManager.grey2;
  Color get grey3 => _isDark ? ColorManager.darkGrey3 : ColorManager.grey3;
  Color get grey4 => _isDark ? ColorManager.darkGrey4 : ColorManager.grey4;
  Color get grey5 => _isDark ? ColorManager.darkGrey5 : ColorManager.grey5;
  Color get grey6 => _isDark ? ColorManager.darkGrey6 : ColorManager.grey6;

  // Functional Colors
  Color get error => _isDark ? ColorManager.darkError : ColorManager.error;
  Color get success => _isDark ? ColorManager.darkSuccess : ColorManager.success;
  Color get warning => _isDark ? ColorManager.darkWarning : ColorManager.warning;
  Color get info => _isDark ? ColorManager.darkInfo : ColorManager.info;

  // Core Colors (same in both themes)
  Color get white => ColorManager.white;
  Color get black => ColorManager.black;
}
