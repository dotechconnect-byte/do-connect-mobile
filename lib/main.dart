import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'core/providers/theme_provider.dart';
import 'core/theme/app_theme.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          // Update system UI overlay style based on theme
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
              systemNavigationBarColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
              systemNavigationBarIconBrightness: themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
            ),
          );

          return ScreenUtilInit(
            designSize: const Size(375, 812), // iPhone 11 Pro dimensions
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (context, child) {
              return MaterialApp(
                title: 'Do Connect',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme,
                darkTheme: AppTheme.darkTheme,
                themeMode: themeProvider.themeMode,
                home: const OnboardingScreen(),
              );
            },
          );
        },
      ),
    );
  }
}
