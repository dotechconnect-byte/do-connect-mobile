import 'package:flutter/material.dart';
import '../consts/color_manager.dart';

/// Helper class to get theme-aware colors throughout the app
/// Usage: ThemeHelper.of(context).background
class ThemeHelper {
  final BuildContext context;

  ThemeHelper.of(this.context);

  bool get _isDark => Theme.of(context).brightness == Brightness.dark;

  // Background Colors
  Color get background => _isDark ? ColorManager.darkBackground : ColorManager.backgroundColor;
  Color get cardBackground => _isDark ? ColorManager.darkCardBackground : ColorManager.white;
  Color get white => ColorManager.white;

  // Primary Colors
  Color get primary => _isDark ? ColorManager.darkPrimary : ColorManager.primary;
  Color get primaryDark => _isDark ? ColorManager.darkPrimaryDark : ColorManager.primaryDark;
  Color get primaryLight => _isDark ? ColorManager.darkPrimaryLight : ColorManager.primaryLight;

  // Text Colors
  Color get textPrimary => _isDark ? ColorManager.darkTextPrimary : ColorManager.textPrimary;
  Color get textSecondary => _isDark ? ColorManager.darkTextSecondary : ColorManager.textSecondary;
  Color get textTertiary => _isDark ? ColorManager.darkTextTertiary : ColorManager.textTertiary;

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
}
