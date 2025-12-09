import 'package:flutter/material.dart';

class ColorManager {
  // Premium Brand Colors
  static const Color primary = Color(0xFF10B981); // Emerald Green
  static const Color primaryDark = Color(0xFF059669);
  static const Color primaryLight = Color(0xFF34D399);

  // Onboarding Gradient Colors
  // Screen 1 - Green
  static const Color onboardingGreen1 = Color(0xFF10B981);
  static const Color onboardingGreen2 = Color(0xFF34D399);

  // Screen 2 - Pink/Orange
  static const Color onboardingPink1 = Color(0xFFEC4899);
  static const Color onboardingPink2 = Color(0xFFF97316);
  static const Color onboardingOrange = Color(0xFFFBBF24);

  // Screen 3 - Blue
  static const Color onboardingBlue1 = Color(0xFF3B82F6);
  static const Color onboardingBlue2 = Color(0xFF06B6D4);

  // Screen 4 - Purple
  static const Color onboardingPurple1 = Color(0xFF8B5CF6);
  static const Color onboardingPurple2 = Color(0xFFA855F7);

  // Gradient Lists for Onboarding
  static const List<Color> trackingGradient = [
    onboardingGreen1,
    onboardingGreen2,
  ];

  static const List<Color> earningsGradient = [
    onboardingPink1,
    onboardingPink2,
    onboardingOrange,
  ];

  static const List<Color> jobsGradient = [
    onboardingBlue1,
    onboardingBlue2,
  ];

  static const List<Color> welcomeGradient = [
    onboardingPurple1,
    onboardingPurple2,
  ];

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
  static const Color error = Color(0xFFEF4444);
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
}
