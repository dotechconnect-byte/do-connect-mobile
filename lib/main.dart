import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/consts/color_manager.dart';
import 'core/consts/font_manager.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone 11 Pro dimensions
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Do Connect',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorManager.primary,
              primary: ColorManager.primary,
              secondary: ColorManager.primaryLight,
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
              iconTheme: IconThemeData(color: ColorManager.textPrimary),
              titleTextStyle: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: ColorManager.textPrimary,
              ),
            ),
          ),
          home: const OnboardingScreen(),
        );
      },
    );
  }
}
