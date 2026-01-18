import 'package:flutter/material.dart';

class ColorManager {
  // Premium Brand Colors - Orange Theme
  static const Color primary = Color(0xFFFF6B35); // Vibrant Orange
  static const Color primaryDark = Color(0xFFE85A2B);
  static const Color primaryLight = Color(0xFFFF8C5F);

  // Onboarding Colors - Orange Theme
  static const Color onboardingIconBg = Color(0xFFFFF4ED); // Light peach
  static const Color onboardingIconColor = Color(0xFFFF6B35); // Primary Orange
  static const Color onboardingAccent = Color(0xFFFFE5D9); // Very light orange
  static const Color onboardingDot = Color(0xFFFFD4C0); // Inactive dot
  static const Color onboardingDotActive = Color(0xFFFF6B35); // Active dot

  // Core Colors
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color black2 = Color(0xFF1F1F1F);
  static const Color black3 = Color(0xFF282828);

  // Grey Scale
  static const Color grey = Color(0xFF6B7280);
  static const Color grey1 = Color(0xFF4B5563);
  static const Color grey2 = Color(0xFF9CA3AF);
  static const Color grey3 = Color(0xFFD1D5DB);
  static const Color grey4 = Color(0xFFE5E7EB);
  static const Color grey5 = Color(0xFFF3F4F6);
  static const Color grey6 = Color(0xFFF9FAFB);

  // Functional Colors
  static const Color error = Color.fromARGB(255, 156, 18, 18);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Background Colors
  static const Color backgroundColor = Color(0xFFF9FAFB);
  static const Color cardBackground = Color(0xFFFFFFFF);
  static const Color overlayBackground = Color(0x80000000);

  // Text Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textTertiary = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);

  // Auth & Premium Colors
  static const Color authPrimary = Color(0xFF7C3AED); // Deep Vibrant Purple
  static const Color authPrimaryDark = Color(0xFF6D28D9);
  static const Color authPrimaryLight = Color(0xFF8B5CF6);
  static const Color authAccent = Color(0xFFA78BFA); // Light Purple

  // Auth Background & Surface Colors
  static const Color authBackground = Color(0xFFFAFAFC); // Slight purple tint white
  static const Color authSurface = Color(0xFFF5F3FF); // Very light purple
  static const Color authInputBackground = Color(0xFFF5F3FF); // Light purple input
  static const Color authInputBorder = Color(0xFFE9D5FF); // Lighter purple border

  // Auth Gradient
  static const List<Color> authGradient = [
    Color(0xFF7C3AED),
    Color(0xFF8B5CF6),
  ];

  // Auth Secondary Actions
  static const Color authSecondary = Color(0xFFF3F4F6); // Light grey for inactive states
  static const Color authSecondaryText = Color(0xFF6B7280); // Grey text

  // ========== DARK MODE COLORS ==========

  // Dark Mode - Brand Colors (Keep orange vibrant)
  static const Color darkPrimary = Color(0xFFFF7A4D); // Slightly lighter orange for dark bg
  static const Color darkPrimaryDark = Color(0xFFFF6B35);
  static const Color darkPrimaryLight = Color(0xFFFF9A70);

  // Dark Mode - Background Colors
  static const Color darkBackground = Color(0xFF0F0F0F); // Deep dark background
  static const Color darkCardBackground = Color(0xFF1A1A1A); // Card background
  static const Color darkSurfaceVariant = Color(0xFF242424); // Alternative surface
  static const Color darkOverlayBackground = Color(0x80000000);

  // Dark Mode - Grey Scale
  static const Color darkGrey = Color(0xFF9CA3AF);
  static const Color darkGrey1 = Color(0xFFB5BCC5);
  static const Color darkGrey2 = Color(0xFF6B7280);
  static const Color darkGrey3 = Color(0xFF4B5563);
  static const Color darkGrey4 = Color(0xFF374151);
  static const Color darkGrey5 = Color(0xFF2A2F38);
  static const Color darkGrey6 = Color(0xFF1F2937);

  // Dark Mode - Text Colors
  static const Color darkTextPrimary = Color(0xFFF3F4F6); // Very light grey
  static const Color darkTextSecondary = Color(0xFFD1D5DB); // Medium light grey
  static const Color darkTextTertiary = Color(0xFF9CA3AF); // Medium grey
  static const Color darkTextOnPrimary = Color(0xFF0F0F0F); // Dark text on orange

  // Dark Mode - Functional Colors (Adjusted for dark background)
  static const Color darkError = Color(0xFFF87171); // Lighter red
  static const Color darkSuccess = Color(0xFF34D399); // Lighter green
  static const Color darkWarning = Color(0xFFFBBF24); // Lighter amber
  static const Color darkInfo = Color(0xFF60A5FA); // Lighter blue
}
