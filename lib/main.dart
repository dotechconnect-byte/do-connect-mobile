import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/providers/theme_provider.dart';
import 'core/services/notification_service.dart';
import 'core/theme/app_theme.dart';
import 'features/notifications/presentation/bloc/notification_bloc.dart';
import 'features/onboarding/presentation/pages/onboarding_screen.dart';
import 'firebase_options.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up background message handler
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Set up dependency injection
  setupLocator();

  // Initialize notification service
  await NotificationService().initialize();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NotificationBloc>(
          create: (_) => locator<NotificationBloc>(),
        ),
      ],
      child: ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (context, themeProvider, _) {
            // Update system UI overlay style based on theme
            SystemChrome.setSystemUIOverlayStyle(
              SystemUiOverlayStyle(
                statusBarColor: Colors.transparent,
                statusBarIconBrightness:
                    themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
                systemNavigationBarColor:
                    themeProvider.isDarkMode ? Colors.black : Colors.white,
                systemNavigationBarIconBrightness:
                    themeProvider.isDarkMode ? Brightness.light : Brightness.dark,
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
      ),
    );
  }
}
